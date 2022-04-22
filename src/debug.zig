const std = @import("std");
const Chunk = @import("Chunk.zig");
const value = @import("value.zig");

pub fn disassembleChunk(chunk: Chunk, name: []const u8) void {
    std.debug.print("== {s} ==\n", .{name});

    var offset: u32 = 0;
    while (offset < chunk.code.items.len) {
        offset = disassembleInstruction(chunk, offset);
    }
}

fn simpleInstruction(name: []const u8, offset: u32) u32 {
    std.debug.print("{s}\n", .{name});
    return offset + 1;
}

fn constantInstruction(name: []const u8, chunk: Chunk, offset: u32) u32 {
    const constant = chunk.code.items[offset + 1];
    std.debug.print("{s:<16} {d:0>4} '", .{ name, constant });
    value.printValue(chunk.constants.items[constant]);
    std.debug.print("'\n", .{});
    return offset + 2;
}

fn disassembleInstruction(chunk: Chunk, offset: u32) u32 {
    std.debug.print("{d:0>4} ", .{offset});

    if (offset > 0 and chunk.lines.items[offset] == chunk.lines.items[offset - 1]) {
        std.debug.print("   | ", .{});
    } else {
        std.debug.print("{d:4} ", .{chunk.lines.items[offset]});
    }

    const instruction = @intToEnum(Chunk.OpCode, chunk.code.items[offset]);
    switch (instruction) {
        .OpReturn => return simpleInstruction("OP_RETURN", offset),
        .OpConstant => return constantInstruction("OP_CONSTANT", chunk, offset),
    }
}

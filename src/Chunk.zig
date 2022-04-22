const std = @import("std");
const Allocator = std.mem.Allocator;

const ValueArray = @import("value.zig").ValueArray;
const Value = @import("value.zig").Value;

code: std.ArrayList(u8),
constants: ValueArray,
lines: std.ArrayList(u32),

pub const OpCode = enum(u8) {
    OpReturn,
    OpConstant,
};

const Chunk = @This();

pub fn init(allocator: Allocator) Chunk {
    return Chunk{
        .code = std.ArrayList(u8).init(allocator),
        .constants = ValueArray.init(allocator),
        .lines = std.ArrayList(u32).init(allocator),
    };
}

pub fn deinit(chunk: *Chunk) void {
    chunk.code.deinit();
    chunk.constants.deinit();
    chunk.lines.deinit();
}

pub fn writeOp(chunk: *Chunk, op: OpCode, line: u32) !void {
    try chunk.code.append(@enumToInt(op));
    try chunk.lines.append(line);
}

pub fn write(chunk: *Chunk, byte: u8, line: u32) !void {
    try chunk.code.append(byte);
    try chunk.lines.append(line);
}

pub fn addConstant(chunk: *Chunk, value: Value) !u8 {
    try chunk.constants.append(value);
    return @intCast(u8, chunk.constants.items.len - 1);
}

const std = @import("std");
const Chunk = @import("Chunk.zig");
const debug = @import("debug.zig");
const VM = @import("VM.zig");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub fn main() anyerror!void {
    var chunk = Chunk.init(gpa.allocator());
    defer chunk.deinit();

    var vm = VM.init(gpa.allocator());
    defer vm.deinit();

    const constant = try chunk.addConstant(1.2);
    try chunk.writeOp(.OpConstant, 123);
    try chunk.write(constant, 123);

    try chunk.writeOp(.OpReturn, 123);

    debug.disassembleChunk(chunk, "test chunk");
}

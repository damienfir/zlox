const std = @import("std");
const Chunk = @import("chunk.zig");

var gpa = std.heap.GeneralPurposeAllocator(.{});

pub fn main() anyerror!void {
    var chunk = Chunk.init(gpa.allocator());
    defer chunk.free();
    try chunk.write(.OpReturn);
}

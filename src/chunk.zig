const std = @import("std");
const Allocator = std.mem.Allocator;

const memory = @import("memory.zig");

const OpCode = enum {
    OpReturn,
};

const Chunk = struct {
    count: usize,
    capacity: usize,
    code: []u8,
    allocator: Allocator,

    pub fn init(allocator: Allocator) Chunk {
        return Chunk{
            .count = 0,
            .capacity = 0,
            .code = undefined,
            .allocator = allocator,
        };
    }

    pub fn free(chunk: *Chunk) void {
        memory.freeArray(chunk.code);
    }

    pub fn write(chunk: *Chunk, byte: u8) !void {
        if (chunk.capacity < chunk.count + 1) {
            const old_capacity = chunk.capacity;
            chunk.capacity = memory.growCapacity(old_capacity);
            chunk.code = try memory.growArray(u8, chunk.code, chunk.capacity);
        }

        chunk.code[chunk.count] = byte;
        chunk.count += 1;
    }
};

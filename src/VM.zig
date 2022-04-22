const std = @import("std");
const Allocator = std.mem.Allocator;
const Chunk = @import("Chunk.zig");

chunk: ?*Chunk = null,
ip: u32 = 0,

const VM = @This();

pub fn init(allocator: Allocator) VM {
    _ = allocator;
    return VM{};
}

pub fn deinit(vm: VM) void {
    _ = vm;
}

const InterpretResult = enum {
    InterpretOk,
    InterpretCompileError,
    InterpretRuntimeError,
};

pub fn interpret(vm: *VM, chunk: *Chunk) !InterpretResult {
    vm.chunk = chunk;
    vm.ip = 0;
    return vm.run();
}

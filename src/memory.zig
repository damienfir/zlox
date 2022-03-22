const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn growCapacity(capacity: usize) usize {
    return if (capacity < 8) 8 else capacity * 2;
}

pub fn growArray(allocator: Allocator, t: type, slice: []t, new_count: usize) ![]t {
    return try reallocate(slice, new_count);
}

pub fn freeArray(allocator: Allocator, slice: anytype) void {
    reallocate(allocator, slice, 0) catch unreachable;
}

pub fn reallocate(allocator: Allocator, slice: anytype, new_count: usize) !@typeInfo(slice).Slice. {
    if (new_count == 0) {
        allocator.free(slice);
        return slice;
    }
    return try allocator.realloc(slice, new_count);
}

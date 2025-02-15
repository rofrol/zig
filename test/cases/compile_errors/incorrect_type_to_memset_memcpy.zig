pub export fn entry() void {
    var buf: [5]u8 = .{ 1, 2, 3, 4, 5 };
    var slice: []u8 = &buf;
    const a: u32 = 1234;
    @memcpy(slice.ptr, @ptrCast([*]const u8, &a));
}
pub export fn entry1() void {
    var buf: [5]u8 = .{ 1, 2, 3, 4, 5 };
    var ptr: *u8 = &buf[0];
    @memcpy(ptr, 0);
}
pub export fn entry2() void {
    var buf: [5]u8 = .{ 1, 2, 3, 4, 5 };
    var ptr: *u8 = &buf[0];
    @memset(ptr, 0);
}
pub export fn non_matching_lengths() void {
    var buf1: [5]u8 = .{ 1, 2, 3, 4, 5 };
    var buf2: [6]u8 = .{ 1, 2, 3, 4, 5, 6 };
    @memcpy(&buf2, &buf1);
}

// error
// backend=stage2
// target=native
//
// :5:5: error: unknown @memcpy length
// :5:18: note: destination type '[*]u8' provides no length
// :5:24: note: source type '[*]align(4) const u8' provides no length
// :10:13: error: type 'u8' does not support indexing
// :10:13: note: operand must be an array, slice, tuple, or vector
// :15:13: error: type '*u8' does not support indexing
// :15:13: note: operand must be an array, slice, tuple, or vector
// :20:5: error: non-matching @memcpy lengths
// :20:13: note: length 6 here
// :20:20: note: length 5 here

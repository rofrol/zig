const S = struct {
    a: u32,
    fn foo(_: *S, _: u32, _: bool) void {}
};
pub export fn entry() void {
    var s: S = undefined;
    s.foo(true);
}
pub export fn entry2() void {
    var s: S = undefined;
    @call(.auto, s.foo, .{true});
}

// error
// backend=stage2
// target=native
//
// :7:6: error: member function expected 2 argument(s), found 1
// :3:5: note: function declared here
// :11:19: error: member function expected 2 argument(s), found 1
// :3:5: note: function declared here

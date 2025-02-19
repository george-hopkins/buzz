const std = @import("std");
const api = @import("buzz_api.zig");

export fn serialize(ctx: *api.NativeCtx) c_int {
    const to_serialize = ctx.vm.bz_peek(0);

    var error_value = api.Value.Void;
    const serialized = ctx.vm.bz_serialize(to_serialize, &error_value);

    if (error_value.val != api.Value.Void.val) {
        ctx.vm.bz_push(error_value);

        return -1;
    }

    ctx.vm.bz_push(serialized);

    return 1;
}

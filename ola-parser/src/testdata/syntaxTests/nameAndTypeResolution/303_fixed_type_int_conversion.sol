contract test {
    fn f() public {
        uint64 a = 3;
        int64 b = 4;
        fixed c = b;
        ufixed d = a;
        c; d;
    }
}
// ----
// UnimplementedFeatureError: Not yet implemented - FixedPointType.
// Warning 2018: (20-147): fn state mutability can be restricted to pure

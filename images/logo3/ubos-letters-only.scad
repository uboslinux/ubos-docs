factor = 8.4/7.5 * 2.54;

linear_extrude(height = 4, center = true, convexity = 10)
scale( [ factor, factor, 0 ] ) {
    import(file = "ubos-letters-only.dxf");
}

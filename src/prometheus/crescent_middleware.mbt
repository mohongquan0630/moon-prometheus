// Crescent integration boundary.
//
// Crescent 0.10.0 is declared as a documented optional integration in
// moon.mod, but its dependency source currently uses syntax rejected by the
// MoonBit 0.10.7 compiler. The core package therefore does not import it:
// this keeps all four project targets reproducible and green. The README
// provides the exact adapter shape for applications that pin a compatible
// Crescent revision.

function band = PassBand(start, stop, TB)
        band = [start start+TB stop-TB stop];
end
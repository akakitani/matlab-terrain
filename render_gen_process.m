function render_gen_process(heightmap, fname, iter, modulus)
    global WRITE_TO_FILE;
    if mod(iter, modulus) == 0
        mesh(heightmap);
        if WRITE_TO_FILE
            saveas(gcf, [fname, sprintf('%07d', iter),'.png'])    
        else
            pause(0.5);
        end
    end
end
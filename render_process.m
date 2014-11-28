function render_gen_process(heightmap, fname, iter, modulus)
    if mod(iter, modulus) == 0
        mesh(heightmap);
        saveas(gcf, [fname, sprintf('%03d', iter),'.png'])        
    end
end
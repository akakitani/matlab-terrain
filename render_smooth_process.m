function render_smooth_process(heightmap, fname, iter, modulus)
    global WRITE_TO_FILE;
    if mod(iter, modulus) == 0
        imshow(heightmap, []);
        if WRITE_TO_FILE
            saveas(gcf, [fname, sprintf('%03d', iter),'.png']) 
        else
            pause(0.5);
        end
    end
end
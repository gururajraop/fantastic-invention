function [] = fill_template()

    template = fileread('reports/template.html');
    replace_field('VOCAB_SIZE', '123');
    

    fn = sprintf('reports/%s-%s.html', 'dense', 'rgb');
    output = fopen(fn, 'w');
    fprintf(output, template);
    
    function replace_field(field, value)
        field = sprintf('{{%s}}', field);        
        template = strrep(template, field,  value);
    end

end


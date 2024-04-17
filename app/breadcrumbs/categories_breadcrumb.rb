class ProductsBreadcrumb < BreadcrumbsOnRails::Breadcrumbs::Builder
    def render
      if @elements.length > 0
        elements = @elements.collect do |element|
          link_or_text = compute_name(element)
          content = @context.link_to_unless_current(link_or_text, compute_path(element))
          "<li>#{content}</li>"
        end
        "<ol class='breadcrumb'>#{elements.join(@options[:separator])}</ol>".html_safe
      end
    end
  end
  
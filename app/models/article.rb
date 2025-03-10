class Article < Posting
  def snippet
    @snippet ||= ArticleSnippetBuilder.new(self).call
  end
end

# TODO: move to separate file
class ArticleSnippetBuilder
  def initialize(article)
    @article = article
  end

  def call
    doc = Nokogiri::HTML::DocumentFragment.parse(@article.body)
    # build snippet using Nokogiri instead of working with raw string
    # don't forget to add `alt` and `data-image` attributes
    doc.to_html
  end

  private

  # original implementation
  # def article_with_image
  #   return type if type != 'Article'

  #   figure_start = body.index('<figure')
  #   figure_end = body.index('</figure>')
  #   return "#{figure_start}_#{figure_end}" if figure_start.nil? || figure_end.nil?

  #   image_tags = body[figure_start...figure_end + 9]
  #   return 'not include <img' unless image_tags.include?('<img')

  #   posting_image_params(image_tags)
  # end

  # private

  # def posting_image_params(html)
  #   tag_parse = -> (image, att) { image.match(/#{att}="(.+?)"/) }
  #   tag_attributes = {}

  #   %w[alt src data-image].each do |attribute|
  #     data = tag_parse.(html, attribute)
  #     unless data.nil?
  #       tag_attributes[attribute] = data[1] unless data.size < 2
  #     end
  #   end
  #   # tag_parse
  #   tag_attributes
  # end
end
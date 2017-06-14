module ApplicationHelper

  def markdown(text)
    options = [:hardwrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Markdown.new(text, *options).to_html.html_safe
  end
end

require 'launchy'

module DeklarativnaUtils
  class HTMLExporter
    @@default_filename = 'rendered_html.html'

    def render_to_file filename, rendered_html
      File.open(filename, 'w') { |f| f.write(rendered_html) }
      filename
    end

    #Requires Firefox or Chrome
    def launch_file_on_browser filename_or_url
      Launchy.open filename_or_url
    end

    #Requires Firefox or Chrome
    def launch_rendered_html_on_browser rendered_html, filename=nil
      filename ||= @@default_filename
      launch_file_on_browser(
        render_to_file filename,
        rendered_html
      )
    end
  end
end


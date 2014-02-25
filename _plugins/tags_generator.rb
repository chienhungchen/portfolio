module Jekyll

  # The TagIndex class creates a single tag page for the specified tag.
  class TagPage < Page

    # Initializes a new TagIndex.
    #
    #  +template_path+ is the path to the layout template to use.
    #  +site+          is the Jekyll Site instance.
    #  +base+          is the String path to the <source>.
    #  +tag_dir+  is the String path between <source> and the tag folder.
    #  +tag+      is the tag currently being processed.
    def initialize(template_path, name, site, base, tag_dir, tag)
      @site  = site
      @base  = base
      @dir   = tag_dir
      @name  = name

      self.process(name)

      if File.exist?(template_path)
        @perform_render = true
        template_dir    = File.dirname(template_path)
        template        = File.basename(template_path)
        # Read the YAML data from the layout page.
        self.read_yaml(template_dir, template)
        self.data['tag']    = tag
        # Set the title for this page.
        title_prefix             = site.config['tag_title_prefix'] || 'Blog Posts with #'
        self.data['title']       = "#{title_prefix}#{tag}"
        # Set the meta-description for this page.
        meta_description_prefix  = site.config['tag_meta_description_prefix'] || 'Blog Posts with #'
        self.data['description'] = "#{meta_description_prefix}#{tag}"
      else
        @perform_render = false
      end
    end

    def render?
      @perform_render
    end

  end

  # The TagIndex class creates a single tag page for the specified tag.
  class TagIndex < TagPage

    # Initializes a new TagIndex.
    #
    #  +site+         is the Jekyll Site instance.
    #  +base+         is the String path to the <source>.
    #  +tag_dir+ is the String path between <source> and the tag folder.
    #  +tag+     is the tag currently being processed.
    def initialize(site, base, tag_dir, tag)
      template_path = File.join(base, '_layouts', 'tag_index.html')
      super(template_path, 'index.html', site, base, tag_dir, tag)
    end

  end

  # The TagFeed class creates an Atom feed for the specified tag.
  class TagFeed < TagPage

    # Initializes a new TagFeed.
    #
    #  +site+         is the Jekyll Site instance.
    #  +base+         is the String path to the <source>.
    #  +tag_dir+ is the String path between <source> and the tag folder.
    #  +tag+     is the tag currently being processed.
    def initialize(site, base, tag_dir, tag)
      template_path = File.join(base, '_includes', 'custom', 'tag_feed.xml')
      super(template_path, 'atom.xml', site, base, tag_dir, tag)

      # Set the correct feed URL.
      self.data['feed_url'] = "#{tag_dir}/#{name}" if render?
    end

  end

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    # Creates an instance of TagIndex for each tag page, renders it, and
    # writes the output to a file.
    #
    #  +tag+ is the tag currently being processed.
    def write_tag_index(tag)
      target_dir = GenerateTags.tag_dir(self.config['tag_dir'], tag)
      index      = TagIndex.new(self, self.source, target_dir, tag)
      if index.render?
        index.render(self.layouts, site_payload)
        index.write(self.dest)
        # Record the fact that this pages has been added, otherwise Site::cleanup will remove it.
        self.pages << index
      end

      # Create an Atom-feed for each index.
      feed = TagFeed.new(self, self.source, target_dir, tag)
      if feed.render?
        feed.render(self.layouts, site_payload)
        feed.write(self.dest)
        # Record the fact that this pages has been added, otherwise Site::cleanup will remove it.
        self.pages << feed
      end
    end

    # Loops through the list of tag pages and processes each one.
    def write_tag_indexes
      if self.layouts.key? 'tag_index'
        self.tags.keys.each do |tag|
          self.write_tag_index(tag)
        end

      # Throw an exception if the layout couldn't be found.
      else
        throw "No 'tag_index' layout found."
      end
    end

  end


  # Jekyll hook - the generate method is called by jekyll, and generates all of the tag pages.
  class GenerateTags < Generator
    safe true
    priority :low

    TAG_DIR = 'tags'

    def generate(site)
      site.write_tag_indexes
    end

    # Processes the given dir and removes leading and trailing slashes. Falls
    # back on the default if no dir is provided.
    def self.tag_dir(base_dir, tag)
      base_dir = (base_dir || TAG_DIR).gsub(/^\/*(.*)\/*$/, '\1')
      tag = tag.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase
      File.join(base_dir, tag)
    end

  end


  # Adds some extra filters used during the tag creation process.
  module Filters

    # Outputs a list of tags as comma-separated <a> links. This is used
    # to output the tag list for each post on a tag page.
    #
    #  +tags+ is the list of tags to format.
    #
    # Returns string
    def tag_links(tags)
      base_dir = @context.registers[:site].config['tag_dir']
      tags = tags.sort!.map do |tag|
        tag_dir = GenerateTags.tag_dir(base_dir, tag)
        # Make sure the tag directory begins with a slash.
        tag_dir = "/#{tag_dir}" unless tag_dir =~ /^\//
        "<a class='tag' href='#{tag_dir}/'>#{tag}</a>"
      end

      case tags.length
      when 0
        ""
      when 1
        tags[0].to_s
      else
        tags.join(', ')
      end
    end

    # Outputs the post.date as formatted html, with hooks for CSS styling.
    #
    #  +date+ is the date object to format as HTML.
    #
    # Returns string
    def date_to_html_string(date)
      result = '<span class="month">' + date.strftime('%b').upcase + '</span> '
      result += date.strftime('<span class="day">%d</span> ')
      result += date.strftime('<span class="year">%Y</span> ')
      result
    end

  end

end
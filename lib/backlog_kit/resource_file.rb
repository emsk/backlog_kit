module BacklogKit
  class ResourceFile
    attr_accessor(:filename, :content)

    def initialize(filename, content)
      @filename = filename
      @content  = content
    end
  end
end

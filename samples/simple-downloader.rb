Shoes.app do
  background "#eee"
  @list = stack do
    para "Enter a URL to download:", :margin => [10, 8, 10, 0]
    flow :margin => 10 do
      @url = edit_line :width => -120
      @url.text ='http://shoes.mvmanila.com'
      button "Download", :width => 120 do
        @list.append do
          stack do
            background "#eee".."#ccd"
            stack :margin => 10 do
              dld = nil
              para @url.text, " [", link("cancel") { dld.abort }, "]", :margin => 0
              d = inscription "Beginning transfer.", :margin => 0
              p = progress :width => 1.0, :height => 14
              dld = download @url.text, :save => File.basename(@url.text),
                :progress => proc { |dl| 
                  puts"progress callback"
                  d.text = "Transferred #{dl.transferred} of #{dl.length} bytes (#{dl.percent}%)"
                  puts "progress return #{dl.transferred} of #{dl.length} bytes (#{dl.percent}%)"
                  p.fraction = dl.percent
                  },
                :finish => proc { |dl| 
                  puts "finish callback"
                  d.text = "Download completed"
                  }
            end
          end
        end
      end
    end
  end
end

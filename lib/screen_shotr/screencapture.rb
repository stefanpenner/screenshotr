require 'java'

java_import 'java.awt.Robot'
java_import 'java.awt.Toolkit'
java_import 'java.awt.Rectangle'
java_import 'java.awt.Image'
java_import 'java.awt.image.BufferedImage'
java_import 'javax.imageio.ImageIO'
java_import 'java.awt.datatransfer.StringSelection'

require 'rest_client'

module ScreenShotr
  module ScreenCapture
    extend self
    def snap
      screenRect = Rectangle.new(Toolkit.getDefaultToolkit().getScreenSize())
      capture    = Robot.new.createScreenCapture(screenRect)

      ImageIO.write(capture,'jpg',java.io.File.new('_tmp.jpg'))
      # lets not bother reading, straight to mem and out?
      # or temp file, lets try both
      puts 'picture been took'
      puts 'uploading picture...'

      puts public_url = RestClient.post('http://0.0.0.0:9292/picture/create',
                        :file => File.new('_tmp.jpg'))

      # get URL

      puts 'picture uploaded!'
      ss = StringSelection.new(public_url)
      Toolkit.getDefaultToolkit().getSystemClipboard().setContents(ss, nil)
    ensure
      FileUtils.rm_rf '_tmp.jpg'
    end
  end
end

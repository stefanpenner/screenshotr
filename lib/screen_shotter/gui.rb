require 'java'
java_import 'javax.swing.JFrame'
java_import 'javax.swing.JDialog'
java_import 'javax.swing.JLabel'
java_import 'java.awt.BorderLayout'
java_import 'java.awt.SystemTray'
java_import 'java.awt.Image'
java_import 'java.awt.Toolkit'
java_import 'java.awt.PopupMenu'
java_import 'java.awt.MenuItem'
java_import 'java.awt.TrayIcon'
java_import 'java.awt.event.ActionListener'
java_import 'java.awt.event.MouseListener'

module ScreenShotter
  class Gui < JFrame
    java_implements 'ActionListener'

    def initialize
      super
      run
    end

    def run
      tray.add tray_icon
    end

    def tray
      @tray ||= SystemTray.getSystemTray
    end

    def popup_menu
      popup = PopupMenu.new

      popup.add(screen_shot_item)
      popup.add(exit_item)
      popup
    end

    def image_from_relative_path(path)
      Toolkit.getDefaultToolkit().getImage(File.expand_path(path,__FILE__))
    end

    def tray_icon
      image = image_from_relative_path "../screenshoticon.gif"

      trayIcon = TrayIcon.new(image,"Tray Demo",popup_menu)
      trayIcon.setImageAutoSize(true)
      trayIcon
    end

    def exit_item
      exitItem     = MenuItem.new("exit")
      exitListener = ActionListener.new

      def exitListener.actionPerformed(e)
        java.lang.System.exit(0)
      end

      exitItem.addActionListener(exitListener)
      exitItem
    end

    def screen_shot_item
      screenShotItem     = MenuItem.new("take screen shot")
      screenShotListener = ActionListener.new

      def screenShotListener.actionPerformed(e)
        ScreenShotter::ScreenCapture.snap
      end

      screenShotItem.addActionListener(screenShotListener)
      screenShotItem
    end
  end
end

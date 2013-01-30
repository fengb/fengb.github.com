require 'prawn'


module Fengb
  class Resume < Prawn::Document
    def section(title, body)
      draw_text title, :at => [0, cursor-10], :size => 14
      bounding_box([100, cursor], :width => margin_box.width - 100) do
        text body
      end
    end
  end
end

Fengb::Resume.generate('resume.pdf') do
  text 'Benjamin Feng', :align => :center, :size => 18, :style => :bold

  section 'Objective', 'To solve intriguing and intricate problems with emphasis on usability, maintainability, and correctness.'

  section 'Skills', "Languages: C, Javascript, Objective-C, Python, Ruby, SQL\n"+
                    "Frameworks: Django, jQuery, Ruby on Rails\n"+
                    "Versioning: Git, Mercurial, Perforce, Subversion\n"+
                    "Software: Adobe Photoshop, Keynote, vi"

  section 'Education', "B.S. Computer Engineering - Sep 2003 to May 2007\n"+
                       "Rose-Hulman Institute of Technology\n"+
                       "Minor in Computer Science, Economics"
end

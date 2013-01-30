require 'prawn'


module Fengb
  class Resume < Prawn::Document
    def section(title, body=nil, &block)
      text_box title, :at => [0, cursor], :size => 14
      bounding_box([100, cursor], :width => margin_box.width - 100) do
        if body.nil?
          yield
        else
          text body
        end
      end
    end

    def skill(category, values)
      text_box category << ':', :at => [0, cursor]
      text values, :indent_paragraphs => 80
    end
  end
end

Fengb::Resume.generate('resume.pdf') do
  text 'Benjamin Feng', :align => :center, :size => 18, :style => :bold

  section 'Objective', 'To solve intriguing and intricate problems with emphasis on usability, maintainability, and correctness.'

  section 'Skills' do
    skill 'Languages', 'C, Javascript, Objective-C, Python, Ruby, SQL'
    skill 'Frameworks', 'Django, jQuery, Ruby on Rails'
    skill 'Versioning', 'Git, Mercurial, Perforce, Subversion'
    skill 'Software', 'Adobe Photoshop, Keynote, vi'
  end

  section 'Education' do
    text 'B.S. Computer Engineering - Sep 2003 to May 2007'
    text 'Rose-Hulman Institute of Technology'
    text 'Minor in Computer Science, Economics'
  end
end

#!/usr/bin/env ruby
# encoding: utf-8


require 'prawn'
require 'date'


module Fengb
  class Resume < Prawn::Document
    GUTTER = 8
    LINK_COLOR = '435c96'

    def link(url, text)
      "<color rgb='#{LINK_COLOR}'><link href='#{url}'>#{text}</link></color>"
    end

    def section(title, body=nil, &block)
      move_down GUTTER

      text_box title, :at => [0, cursor], :width => (100 - 2*GUTTER), :align => :right, :size => 14, :style => :bold
      bounding_box([100, cursor], :width => bounds.width - 100) do
        if body.nil?
          yield
        else
          text body
        end

        stroke do
          vertical_line bounds.top+2, bounds.bottom, :at => -GUTTER
        end
      end
    end

    def skill(category, values)
      text_box category << ':', :at => [0, cursor]
      text values, :indent_paragraphs => 62
    end

    def entry(options)
      start_date = options[:start_date].strftime('%b %Y')
      end_date = options[:end_date] ? options[:end_date].strftime('%b %Y') : 'present'

      text "<b><font size='12'>#{options[:title]}</font></b> — #{start_date} to #{end_date}", :inline_format => true
      text link(options[:url], options[:location]), :inline_format => true, :style => :bold
      if block_given?
        yield
      end
      move_down GUTTER
    end

    def ul(*values)
      table values.map{|e| ['•', e]}, :cell_style => {:borders => [], :padding => 0}
    end
  end
end

Fengb::Resume.generate('resume.pdf') do
  font_size 10
  text 'Benjamin Feng', :align => :center, :size => 18, :style => :bold
  text "#{link('+1-312-725-2842', '(312) 725-2842')} • #{link('mailto:contact@fengb.info', 'contact@fengb.info')}",
         :inline_format => true, :align => :center

  section 'Objective', 'To solve intriguing and intricate problems with emphasis on usability, maintainability, and correctness.'

  section 'Skills' do
    skill 'Languages', 'C, Javascript, Objective-C, Python, Ruby, SQL'
    skill 'Frameworks', 'Django, jQuery, Ruby on Rails'
    skill 'Versioning', 'Git, Mercurial, Perforce, Subversion'
    skill 'Software', 'Adobe Photoshop, Keynote, vi'
  end

  section 'Employment' do
    entry(:title => 'Sr. Software Engineer II',
          :location => 'Enova Financial',
          :url => 'http://www.enova.com/',
          :start_date => Date.new(2009, 10, 26)) do
      ul('Engineered customer driven full-stack solutions for websites with millions of yearly transactions',
         'Hardened security by eliminating potential attack vectors',
         'Mentored peers and junior developers through pair programming and lightning talks')
    end

    entry(:title => 'Chief Technical Officer',
          :location => 'Crusader Storm (defunct)',
          :url => 'http://web.archive.org/web/20100623115357/http://www.crusaderstorm.com/',
          :start_date => Date.new(2010, 5, 7),
          :end_date => Date.new(2011, 5, 7)) do
      ul('Incubated iPhone app from concept to release',
         'Designed website using responsive web and graceful degradation techniques',
         'Produced original artwork for branding and marketing')
    end

    entry(:title => 'Software Engineer',
          :location => 'Business Logic Corporation',
          :url => 'http://businesslogic.com/',
          :start_date => Date.new(2007, 6, 4),
          :end_date => Date.new(2009, 8, 4)) do
      ul('Repurposed existing single-threaded financial advice engine into a scalable aggregator',
         'Maintained legacy SOAP API layer for a redesigned modern RESTful architecture',
         'Created testing framework for separating data configuration and verification')
    end

    entry(:title => 'Computer Engineering Intern',
          :location => 'Rose-Hulman Ventures',
          :url => 'http://rhventures.org/',
          :start_date => Date.new(2005, 6, 6),
          :end_date => Date.new(2007, 3, 16)) do
      ul('Coordinated development team to build a website for managing recorded medical audio transcriptions',
         'Optimized chemical control software for space efficiency',
         'Enhanced C++ MFC application integrating with embedded circuit boards')
    end
  end

  section 'Education' do
    entry(:title => 'B.S. Computer Engineering',
          :location => 'Rose-Hulman Institute of Technology',
          :url => 'http://www.rose-hulman.edu/',
          :start_date => Date.new(2003, 9, 4),
          :end_date => Date.new(2007, 5, 26)) do
      text 'Minor in Computer Science, Economics'
    end
  end
end

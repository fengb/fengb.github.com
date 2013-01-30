#!/usr/bin/env ruby
# encoding: utf-8


require 'prawn'
require 'date'


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

    def entry(options)
      text "#{options[:title]} - #{options[:start_date]} to #{options[:end_date]}"
      text "<link href='#{options[:url]}'>#{options[:location]}</link>", :inline_format => true
      if block_given?
        yield
      end
    end

    def ul(*values)
      table values.map{|e| ['•', e]}, :cell_style => {:borders => [], :padding => 0}
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

  section 'Employment' do
    entry(:title => 'Sr. Software Engineer II',
          :location => 'Enova Financial',
          :url => 'http://www.enova.com/',
          :start_date => Date.new(2009, 10, 26),
          :end_date => 'present') do
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

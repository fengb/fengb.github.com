---
layout: false
---
require 'date'

class << pdf
  # Primitives
  def date_range(from, to)
    "#{date_fmt(from)} - #{date_fmt(to)}"
  end

  def date_fmt(date)
    Date.parse(date).strftime("%b '%y") rescue date
  end

  def link(text, url)
    "<color rgb='435c96'><link href='#{url}'>#{text}</link></color>"
  end

  def gutter
    7
  end

  # Definitions
  def header(title, nav: {})
    text title, align: :center, size: 18, style: :bold
    move_up 1
    font_size 11 do
      text nav.map{|text, url| link(text, url)}.join('  •  '), inline_format: true, align: :center
    end
  end

  def sec1(title)
    move_down 1.5*gutter

    text_box title, at: [gutter, cursor+1], size: 17.3, style: :bold, rotate: 270
    indent 3*gutter do
      bounding_box([0, cursor], width: bounds.width) do
        move_up gutter
        yield

        stroke do
          vertical_line bounds.top+1, bounds.bottom+2, at: -gutter
        end
      end
    end
  end

  def sec2(name, description: nil)
    move_down gutter

    text name, inline_format: true, size: 13, style: :bold

    if description
      font 'Times-Roman' do
        text_box description, at: [2*gutter + 140, cursor + 13.7], inline_format: :true
      end
    end

    if block_given?
      move_up gutter
      indent 2*gutter do
        yield
      end
    end
  end

  def sec3(*titles, padding: gutter, subtitle: nil, description: nil)
    move_down padding

    text titles.join('<br>'), size: 10, style: :bold, inline_format: true
    if subtitle
      font 'Courier' do
        move_down 1.3
        text subtitle, size: 10, style: :italic
      end
    end

    if description
      if subtitle
        move_up 24.1
      else
        move_up 12.3
      end
      indent 140 do
        font 'Times-Roman' do
          text description
        end
        if description !~ /\n/ and subtitle
          move_down 10
        end
      end
    end
  end
end

pdf.instance_eval do
  font_size 11
  header 'Benjamin Feng', nav: {'(312) 725-2842'     => 'tel:+1-312-725-2842',
                                'contact@fengb.info' => 'mailto:contact@fengb.info',
                                'github.com/fengb'   => 'https://github.com/fengb'}

  sec1 '.info' do
    sec2 'Objective',    description: 'To solve complex problems with emphasis on simplicity and extensibility'

    sec2 'Skills' do
      sec3 'Languages',  description: 'C, Javascript/Coffeescript, Objective-C, Python, Ruby, SQL'
      sec3 'Frameworks', description: 'Ember.js, jQuery, node.js, Ruby on Rails',     padding: 2
      sec3 'Platforms',  description: 'Linux - Arch / Ubuntu, Mac OS X, Heroku, AWS', padding: 2
    end
  end

  sec1 '.jobs' do
    sec2 link('FENGB TECH', 'http://fengb.info') do
      sec3 '<b><i>Technology Consultant</i></b>'

      sec3 link('Gozent', 'http://www.gozent.com'),
        subtitle: date_range('2013-07-27', '2014-05-29'),
        description: 'Architected MVP for startup
                      Built and automated Amazon Web Services deployment cluster
                      Coordinated with Experian to audit infrastructure'

      sec3 'Bitvain',
        subtitle: date_range('2014-10-18', 'present')
    end

    sec2 link('FENGB NVST', 'http://fengb-nvst.com') do
      sec3 'Managing Partner',
        subtitle: date_range('2013-03-11', 'present'),
        description: 'Investment partnership focused on value investing principles
                      Adjusted yearly performance: 33.25% (equivalent S&P500: 22.65%)
                      Programmed software to automate portfolio tracking and tax matters'
    end

    sec2 link('dough, Inc.', 'http://dough.com') do
      sec3 'Sr. Developer',
        subtitle: date_range('2014-05-05', 'present')
    end

    sec2 link('Enova International', 'http://www.enova.com') do
      sec3 'Lead Software Engineer',
        subtitle: date_range('2013-04-03', '2014-05-02'),
        description: 'Technical team lead for 6 developers and 3 QA
                      Converted design process to lean UX by example
                      Enhanced accounting and underwriting subsystems
                      Implemented data aggregation with Adobe SiteCatalyst reporting suite'

      sec3 'Sr. Software Engineer II',
        subtitle: date_range('2011-07-01', '2013-04-02'),
        description: 'Drove several high priority Sarbanes-Oxley audit related projects
                      Integrated with Lexis Nexis FlexID and Risk View credit reports
                      Extended existing ACH module to communicate with Wells Fargo
                      Trained newly hired developers and managers'

      sec3 'Sr. UI Engineer',
        subtitle: date_range('2010-07-01', '2011-06-30'),
        description: 'Primary UI developer for three product websites
                      Realigned marketing and business to focus on customer experience
                      Launched mobile web for all existing products'

      sec3 'UI Engineer',
        subtitle: date_range('2009-10-19', '2010-06-30'),
        description: 'Launched frontend for new product
                      Ported legacy UI to Rails with modern semantic HTML/CSS'
    end

    sec2 link('Crusader Storm', 'http://web.archive.org/web/20100623115357/http://www.crusaderstorm.com/') do
      sec3 'Founder',
        subtitle: date_range('2010-05-07', '2011-05-06'),
        description: 'Incubated iPhone app from concept to release
                      Developed responsive website with graceful degradation'
    end

    sec2 link('Business Logic', 'http://businesslogic.com/') do
      sec3 'Software Engineer',
        subtitle: date_range('2007-06-04', '2009-08-04'),
        description: 'Converted individual forecasting engine to aggregate company performance
                      Maintained SOAP to REST translation layer for reverse-engineered Java app
                      Created functional testing framework for separating data and verification'
    end
  end

  sec1 '.edu' do
    sec2 link('Rose-Hulman', 'http://www.rose-hulman.edu/') do
      sec3 'B.S. Computer Engineering',
        subtitle: date_range('2003-09-04', '2007-05-26'),
        description: 'Minors in Computer Science & Economics'
    end
  end
end

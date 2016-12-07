---
layout: false
---
require 'date'

class << pdf
  ICONS = {
    bookmarks: "\ue000",
    phone:     "\ue001",
    email:     "\ue002",
    bubble:    "\ue003",
    twitch:    "\ue004",
    github:    "\ue005",
    linkedin:  "\ue006",
    folder:    "\ue007",
    bitcoin:   "\ue008"
  }

  # Primitives
  def date_range(from, to)
    "#{date_fmt(from)} - #{date_fmt(to)}"
  end

  def date_fmt(date)
    Date.parse(date).strftime("%b '%y") rescue date
  end

  def bold(text)
    tag(:b) { text }
  end

  def italic(text)
    tag(:i) { text }
  end

  def link(text, url)
    tag(:color, rgb: '435c96') do
      tag(:link, href: url) { text }
    end
  end

  def icon(name, attributes = {})
    tag(:font, name: 'icon', **attributes) { ICONS[name] }
  end

  def tag(t, **attributes)
    contents = yield if block_given?
    if attributes.empty?
      "<#{t}>#{contents}</#{t}>"
    else
      attr_str = attributes
                 .map { |key, value| "#{key}='#{value}'" }
                 .join(' ')
      "<#{t} #{attr_str}>#{contents}</#{t}>"
    end
  end

  def gutter
    7
  end

  # Definitions

  def sec(title, options = {})
    text title, size: 1.7 * font_size, style: :bold
    indent 1.5 do
      yield
    end
    move_down 2*gutter
  end

  def sub(title, date: nil)
    if date
      font 'Courier' do
        text_box date, size: 0.9 * font_size, at: [0, cursor - 0.8], align: :right, inline_format: true
      end
    end

    text bold(title), inline_format: true

    indent gutter do
      font 'Times-Roman' do
        yield
      end
    end

    move_down gutter
  end

  def blurb(title: nil, date: nil, description: nil)
    move_down gutter/2

    if date
      font 'Courier' do
        text_box date, size: 0.9 * font_size, at: [0, cursor - 0.8], align: :right, inline_format: true
      end
    end

    text italic(title), inline_format: true if title

    if description
      indent gutter do
        text description, inline_format: true
      end
    end
  end

  def contact(sources)
    cursors = []
    indent 14 do
      sources.each_value do |content|
        cursors << cursor
        text content, inline_format: true
      end
    end
    sources.keys.zip(cursors).each do |(name, cursor_value)|
      text_box icon(name), at: [0, cursor_value + 1.5], inline_format: true
    end
  end
end

pdf.instance_eval do
  font_families.update(
    'icon' => { normal: 'source/fonts/icons.ttf' }
  )

  font_size 11

  bounding_box [0, bounds.height], width: 410 do
    sec 'Benjamin Feng' do
      font 'Times-Roman' do
        text 'Lead software engineer with 10 years of experience. Wide range of technology experience from database architecture to UX design. Diverse soft skills project management and mentorship.', size: 12
      end
    end

    sec 'Experience' do
      sub link('Dough', 'http://dough.com') do
        blurb title: 'Sr. Software Developer',
          date: date_range('2014-05-05', 'present'),
          description: 'Architected fresh Ember.js project
                        Optimized database response times via Arel and PostgreSQL queries
                        Promoted various knowledge sharing initiatives such as tech talks
                        Mentored fresh developer graduates'
      end

      sub link('Enova', 'http://www.enova.com') do
        blurb title: 'Lead Software Engineer',
          date: date_range('2013-04-03', '2014-05-02'),
          description: 'Technical team lead for 6 developers and 3 QA
                        Initiated lean UX design principles
                        Improved accounting and underwriting subsystems'

        blurb title: 'Sr. Software Engineer II',
          date: date_range('2011-07-01', '2013-04-02'),
          description: 'Onboarded newly hired developers and managers
                        Drove several high priority Sarbanes-Oxley audit related projects
                        Strengthened risk checks by integrating to Lexis Nexis credit reports
                        Integrated with Wells Fargo ACH deposits'

        blurb title: 'Sr. UI Engineer',
          date: date_range('2010-07-01', '2011-06-30'),
          description: 'Primary UI developer for three product websites
                        Unified marketing needs with customer experience
                        Launched mobile web for existing products'

        blurb title: 'UI Engineer',
          date: date_range('2009-10-19', '2010-06-30'),
          description: 'Launched frontend for new product
                        Ported legacy UI to Rails with modern semantic HTML/CSS'
      end

      sub link('Business Logic', 'http://businesslogic.com/') do
        blurb title: 'Software Engineer',
          date: date_range('2007-06-04', '2009-08-04'),
          description: 'Converted individual forecasting engine to aggregate performance
                        Maintained SOAP to REST translation for legacy API compatibility
                        Created functional testing framework for separating data and verification'
      end
    end

    sub 'Self Employment' do
      blurb title: link('FENGB NVST', 'http://fengb-nvst.com'),
        date: date_range('2013-03-11', 'present'),
        description: 'Investment partnership focused on value investing principles
                      Adjusted yearly performance: 33.25% (equivalent S&P500: 22.65%)
                      Programmed software to automate portfolio tracking and tax matters'

      blurb title: link('Bitvain', 'https://web.archive.org/web/20141227142047/http://www.bitvain.com/'),
        date: date_range('2014-10-18', '2015-01-31'),
        description: 'Designed independently scalable subsystems
                      Integrated Ruby with C extensions to increase performance 100x'

      blurb title: link('Gozent', 'https://web.archive.org/web/20141228062135/https://www.gozent.com/'),
        date: date_range('2013-07-27', '2014-05-29'),
        description: 'Architected MVP for startup
                      Automated Amazon EC2 deployment cluster
                      Coordinated Experian infrastructure audit'
    end

    stroke do
      vertical_line bounds.top + 2, bounds.bottom + 15, at: bounds.right + 20
    end
  end

  bounding_box [440, bounds.height], width: 120, height: bounds.height do
    font_size 10

    sec 'Contact' do
      contact(
        phone: link('(312) 725-2842', 'tel:+13127252842'),
        email: link('contact@fengb.info', 'mailto:contact@fengb.info'),
        github: link('github.com/fengb', 'https://github.com/fengb')
      )
    end

    sec 'Skills' do
      sub 'Javascript' do
        text <<-LIST, inline_format: true
          #{link 'node.js', 'https://nodejs.org'}
          #{link 'Koa', 'http://koajs.com'}
          #{link 'Bookshelf', 'http://bookshelfjs.org'}
          #{link 'Webpack', 'https://webpack.github.io'}
          #{link 'Mocha', 'http://mochajs.org'} / #{link 'Chai', 'http://chaijs.com'}
          #{link 'React', 'https://facebook.github.io/react/'}
          #{link 'Riot', 'http://riotjs.com'}
          #{link 'Ember', 'http://emberjs.com'}
          #{link 'jQuery', 'http://jquery.com'}
        LIST
      end

      sub 'Ruby' do
        text <<-LIST, inline_format: true
          #{link 'Ruby on Rails', 'http://rubyonrails.org'}
          #{link 'Middleman', 'https://middlemanapp.com'}
          #{link 'Arel', 'https://github.com/rails/arel'}
          #{link 'Resque', 'http://resque.github.io'}
          #{link 'Prawn', 'http://prawnpdf.org'}
          #{link 'RSpec', 'http://rspec.info'}
          #{link 'Cucumber', 'https://cucumber.io'}
          #{link 'Capybara', 'http://jnicklas.com/capybara/'}
        LIST
      end

      sub 'iOS' do
        text <<-LIST, inline_format: true
          #{link 'Objective-C', 'https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html'}
          #{link 'Cocoa', 'https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Cocoa.html'}
          #{link 'AFNetworking', 'http://afnetworking.com'}
          #{link 'PhoneGap', 'http://phonegap.com'}
          #{link 'Cocoapods', 'https://cocoapods.org'}
          #{link 'RubyMotion', 'http://www.rubymotion.com'}
        LIST
      end

      sub 'Data' do
        text <<-LIST, inline_format: true
          #{link 'PostgreSQL', 'https://www.postgresql.org'}
          #{link 'SQLite', 'https://sqlite.org'}
          #{link 'Redis', 'http://redis.io'}
          #{link 'ActiveMQ', 'http://activemq.apache.org'}
          #{link 'RabbitMQ', 'https://www.rabbitmq.com'}
        LIST
      end

      sub 'Intermediate' do
        text <<-LIST, inline_format: true
          #{link 'C', 'http://www.open-std.org/jtc1/sc22/wg14/'}
          #{link 'Python', 'https://www.python.org'} – #{link 'Django', 'https://www.djangoproject.com'}
          #{link 'Java', 'https://www.java.com'} – #{link 'Android', 'https://developer.android.com'}
        LIST
      end
    end

    sec 'Education' do
      sub link('Rose-Hulman', 'http://www.rose-hulman.edu'), date: date_fmt('2007-05-26') do
        text 'B.S. Computer Engineering'
        text 'Minor: Comp Science, Economics', size: 0.8*font_size, style: :italic
      end
    end
  end
end

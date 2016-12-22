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

  def u(text)
    tag(:u) { text }
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
    7.0
  end

  # Definitions

  def sec(title, options = {})
    text title, size: 1.5 * font_size, style: :bold, inline_format: true
    indent 1 do
      yield
    end
    move_down gutter
  end

  def sub(title, date: nil)
    if date
      font 'Courier' do
        text_box date, size: 0.9 * font_size, at: [0, cursor - 0.9], align: :right, inline_format: true
      end
    end

    text bold(title), inline_format: true

    indent gutter do
      font 'Times-Roman' do
        yield
      end
    end

    move_down gutter/2
  end

  def blurb(title, date: nil, description: nil)
    if date
      font 'Courier' do
        text_box date, size: 0.9 * font_size, at: [0, cursor - 0.7], align: :right, inline_format: true
      end
    end

    if title
      text italic(title), inline_format: true
    end

    if description
      move_down 1
      indent gutter do
        text description, inline_format: true
      end
    end

    move_down gutter/2
  end

  def header(title, sources)
    text title, align: :center, size: 20, style: :bold
    move_up 1
    text sources.values.join('  •  '), inline_format: true, align: :center
  end
end

pdf.instance_eval do
  #font_families.update(
  #  'icon' => { normal: 'source/fonts/icons.ttf' }
  #)

  font_size 11

  header 'Benjamin Feng',
    phone: link('(312) 725-2842', 'tel:+13127252842'),
    email: link('contact@fengb.me', 'mailto:contact@fengb.me'),
    github: link('github.com/fengb', 'https://github.com/fengb')

  topset = bounds.height - 45
  split = 410

  stroke do
    vertical_line topset, bounds.bottom + 30, at: split
    horizontal_line -gutter, bounds.width + gutter, at: topset
  end

  bounding_box [0, topset - 2*gutter], width: split - 3*gutter do
    sec 'Summary' do
      font 'Times-Roman' do
        text 'Lead software engineer with 10 years of experience specializing in Ruby on Rails, Node.js, React, and PostgreSQL. Proven ability to deliver projects with quality and timeliness. Experience and enthusiasism in team development and mentorship.'
      end
      move_down gutter
    end

    sec 'Experience' do
      sub link('Dough', 'http://dough.com') do
        blurb 'Sr. Software Developer',
          date: date_range('2014-05-05', '2016-10-28'),
          description: 'Lead developer of Ember.js projects
                        Resident DB expert with focus on data import and query response times
                        Migrated critical components from RubyMotion to Objective-C
                        Architected business logic subsystems for Android implementation
                        Instituted mentorship program for junior developers
                        Promoted knowledge sharing via tech talks and code reviews
                        Assisted project management with requirements gathering'
      end

      sub link('Enova', 'http://www.enova.com') do
        blurb 'Lead Software Engineer',
          date: date_range('2013-04-01', '2014-05-02'),
          description: 'Technical team lead for Rails microservice product
                        Initiated lean UX design principles with wireframes and user studies
                        Increased collaboration between backend, DB, UI and QA developers'

        blurb 'Sr. Software Engineer II',
          date: date_range('2011-07-01', '2013-03-31'),
          description: 'Main developer for critical projects — e.g. security and bank integration
                        Collaborated with business stakeholders to manage priorities and estimates
                        Onboarded newly hired developers and managers'

        blurb 'Sr. UI Engineer',
          date: date_range('2010-07-01', '2011-06-30'),
          description: 'Primary UI developer of three products
                        Spearheaded efforts to unify customer experience and marketing needs
                        Launched mobile version of all existing websites'

        blurb 'UI Engineer',
          date: date_range('2009-10-19', '2010-06-30'),
          description: 'Launched frontend for new product
                        Ported legacy UI to Rails with modern semantic HTML/CSS'
      end

      sub link('Business Logic', 'http://businesslogic.com/') do
        blurb 'Software Engineer',
          date: date_range('2007-06-04', '2009-08-04'),
          description: 'Created functional testing framework for separating data and verification
                        Converted individual forecasting engine to aggregate performance
                        Maintained SOAP to REST translation for legacy API compatibility'
      end

      sub 'Self Employment' do
        blurb link('FENGB NVST', 'http://fengb-nvst.com'),
          date: date_range('2013-03-11', 'present'),
          description: 'Investment partnership focused on value investing principles
                        Adjusted yearly performance: 33.25% (equivalent S&P500: 22.65%)
                        Pioneered strategy to normalize gains and dividends against contributions'

        blurb link('Bitvain', 'https://web.archive.org/web/20141227142047/http://www.bitvain.com/'),
          date: date_range('2014-10-18', '2015-01-31'),
          description: 'Integrated Rails with C extensions to increase performance 1000x
                        Extensive Unix programming via forks, signals, named pipes, and blocking IO'

        blurb link('Gozent', 'https://web.archive.org/web/20141228062135/https://www.gozent.com/'),
          date: date_range('2013-07-27', '2014-05-29'),
          description: 'Architected product website with integrations against Stripe and Experian
                        Automated Amazon EC2 deployment cluster'
      end
    end
  end

  bounding_box [split + 2*gutter, topset - 2*gutter], width: 120 do
    font_size 10

    sec 'Skills' do
      sub 'Javascript' do
        text <<-LIST, inline_format: true
          #{link 'Node.js', 'https://nodejs.org'}
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
          #{link 'Rails', 'http://rubyonrails.org'}
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
        LIST
      end

      sub 'Intermediate' do
        text <<-LIST, inline_format: true
          #{link 'C', 'http://www.open-std.org/jtc1/sc22/wg14/'}
          #{link 'Python', 'https://www.python.org'} – #{link 'Django', 'https://www.djangoproject.com'}
          #{link 'Java', 'https://www.java.com'} – #{link 'Android', 'https://developer.android.com'}
          #{link 'ActiveMQ', 'http://activemq.apache.org'}
          #{link 'RabbitMQ', 'https://www.rabbitmq.com'}
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

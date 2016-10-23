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

  def bold(text)
    "<b>#{text}</b>"
  end

  def italic(text)
    "<i>#{text}</i>"
  end

  def link(text, url)
    "<color rgb='435c96'><link href='#{url}'>#{text}</link></color>"
  end

  def gutter
    7
  end

  # Definitions

  def sec(title)
    text title, size: 1.7 * font_size, style: :bold
    yield
    move_down 2*gutter
  end

  def blurb(title, role: nil, date: nil, description:)
    move_down gutter

    if date
      font 'Courier' do
        text_box date, size: 0.9 * font_size, at: [0, cursor - 0.8], align: :right
      end
    end

    title = bold(title)
    if role
      title += " — #{role}"
    end

    text title, inline_format: true

    font 'Times-Roman' do
      indent gutter do
        text description, inline_format: true
      end
    end
  end
end

pdf.instance_eval do
  font_size 11

  bounding_box [0, bounds.height], width: 410 do
    text 'Benjamin Feng', size: 20, style: :italic

    move_down 2*gutter

    sec 'Objective' do
      move_down gutter
      text 'To solve complex problems with emphasis on simplicity and extensibility'
    end

    sec 'Experience' do
      blurb italic(link('Dough', 'http://dough.com')),
        role: 'Sr. Developer',
        date: date_range('2014-05-05', 'present'),
        description: 'Lead development for fresh Ember.js project
                      Optimized database response times via Arel and PostgreSQL queries
                      Promoted various knowledge sharing initiatives such as tech talks
                      Mentored fresh developer graduates'

      blurb italic(link('Enova', 'http://www.enova.com')),
        role: 'Lead Software Engineer',
        date: date_range('2009-10-19', '2014-05-02'),
        description: 'Technical team lead for 6 developers and 3 QA
                      Initiated lean UX design principles
                      Improved accounting and underwriting subsystems
                      Onboarded newly hired developers and managers
                      Drove several high priority Sarbanes-Oxley audit related projects
                      Strengthened risk checks by integrating to Lexis Nexis credit reports
                      Integrated with Wells Fargo ACH deposits
                      Primary UI developer for three product websites
                      Unified marketing needs with customer experience
                      Launched mobile web for existing products
                      Launched frontend for new product
                      Ported legacy UI to Rails with modern semantic HTML/CSS'

      blurb italic(link('Business Logic', 'http://businesslogic.com/')),
        role: 'Software Engineer',
        date: date_range('2007-06-04', '2009-08-04'),
        description: 'Converted individual forecasting engine to aggregate performance
                      Maintained SOAP to REST translation for legacy API compatibility
                      Created functional testing framework for separating data and verification'
    end

    sec 'Self Employment' do
      blurb italic(link('FENGB NVST', 'http://fengb-nvst.com')),
        date: date_range('2013-03-11', 'present'),
        description: 'Investment partnership focused on value investing principles
                      Adjusted yearly performance: 33.25% (equivalent S&P500: 22.65%)
                      Programmed software to automate portfolio tracking and tax matters'

      blurb italic(link('Bitvain', 'https://web.archive.org/web/20141227142047/http://www.bitvain.com/')),
        date: date_range('2014-10-18', '2015-01-31'),
        description: 'Designed independently scalable subsystems
                      Integrated Ruby with C extensions to increase performance 100x'

      blurb italic(link('Gozent', 'https://web.archive.org/web/20141228062135/https://www.gozent.com/')),
        date: date_range('2013-07-27', '2014-05-29'),
        description: 'Architected MVP for startup
                      Automated Amazon EC2 deployment cluster
                      Coordinated Experian infrastructure audit'
    end

    stroke do
      vertical_line bounds.top + 2, bounds.bottom + 15, at: bounds.right + 20
    end
  end

  bounding_box [440, bounds.height], width: 120 do
    text link('(312) 725-2842', 'tel:+1-312-725-2842'), inline_format: true
    text link('contact@fengb.info', 'mailto:contact@fengb.info'), inline_format: true
    text link('github.com/fengb', 'https://github.com/fengb'), inline_format: true

    font_size 10

    move_down 2*gutter

    sec 'Skills' do
      blurb 'Javascript',
        description: <<-LIST
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

      blurb 'Ruby',
        description: <<-LIST
          #{link 'Ruby on Rails', 'http://rubyonrails.org'}
          #{link 'Middleman', 'https://middlemanapp.com'}
          #{link 'Arel', 'https://github.com/rails/arel'}
          #{link 'Resque', 'http://resque.github.io'}
          #{link 'Prawn', 'http://prawnpdf.org'}
          #{link 'RSpec', 'http://rspec.info'}
          #{link 'Cucumber', 'https://cucumber.io'}
          #{link 'Capybara', 'http://jnicklas.com/capybara/'}
        LIST

      blurb 'iOS',
        description: <<-LIST
          #{link 'Objective-C', 'https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html'}
          #{link 'Cocoa', 'https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Cocoa.html'}
          #{link 'AFNetworking', 'http://afnetworking.com'}
          #{link 'PhoneGap', 'http://phonegap.com'}
          #{link 'Cocoapods', 'https://cocoapods.org'}
          #{link 'RubyMotion', 'http://www.rubymotion.com'}
        LIST

      blurb 'Data',
        description: <<-LIST
          #{link 'PostgreSQL', 'https://www.postgresql.org'}
          #{link 'SQLite', 'https://sqlite.org'}
          #{link 'Redis', 'http://redis.io'}
          #{link 'ActiveMQ', 'http://activemq.apache.org'}
          #{link 'RabbitMQ', 'https://www.rabbitmq.com'}
        LIST

      blurb 'Intermediate',
        description: <<-LIST
          #{link 'C', 'http://www.open-std.org/jtc1/sc22/wg14/'}
          #{link 'Python', 'https://www.python.org'} – #{link 'Django', 'https://www.djangoproject.com'}
          #{link 'Java', 'https://www.java.com'} – #{link 'Android', 'https://developer.android.com'}
        LIST
    end

    sec 'Education' do
      blurb italic(link('Rose-Hulman', 'http://www.rose-hulman.edu')),
        date: date_fmt('2007-05-26'),
        description: 'B.S. Computer Engineering'
    end
  end
end

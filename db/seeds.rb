names = ['Frankie Yellow', 'Amanda Teal', 'Chloe Gray', 'Ben Brown', 'Chris Green', 'Corey Black', 'Mick White', 'Rachel Blue', 'Kate Magenta', 'Clair Orange']
# create guests
guests = names.map do |name|
  email_name = name.downcase.gsub(' ', '.')
  User.create(
    email: "#{email_name}@email.com",
    name: name,
  )   
end

# create plans and host
host = User.find_or_create_by(name: 'Marcus Gold', email: 'marcus.gold@email.com', image: 'http://graph.facebook.com/580644047/picture')
open_plan =   Plan.create(what: "The Black Keys",
                            when:  3.weeks.from_now,
                            where: "Entertainment Centre",
                            user_id: host.id,
                            deadline: 2.weeks.from_now,
                            price: 90,
                            demo: true)
closed_plan = Plan.create(what: "Sydney Swans vs West Coast Eagles",
                            when:  3.weeks.from_now,
                            where: "Sydney Cricket Ground",
                            user_id: host.id,
                            deadline: 1.day.ago,
                            price: 60,
                            booked: true,
                            demo: true)

rsvps = ['going', 'not-going', 'maybe', 'undecided']
# create invites for plans
open_plan.invites.create(user_id: host.id, rsvp: 'going')
closed_plan.invites.create(user_id: host.id, rsvp: 'going')

open_plan.media.create!(url: 'http://a.dilcdn.com/bl/wp-content/uploads/sites/8/2012/04/TheBlackKeys.jpg', media_type: 'image')
open_plan.media.create!(source_id: '0MhwaBVJghoZsEzHbr0qjl' , media_type: 'spotify')
open_plan.media.create!(url: 'https://www.youtube.com/watch?v=a_426RiwST8', media_type: 'youtube')

guests.map do |guest|
  open_plan.invites.create(user_id: guest.id, rsvp: rsvps.sample)
  closed_plan.invites.create(user_id: guest.id, rsvp: rsvps.sample) 
end

# add media for plans, video music images

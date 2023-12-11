# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
p "Destroyed all users"
Instrument.destroy_all
p "Destroyed all instruments"
Profile.destroy_all
p "Destroyed all profiles"
Role.destroy_all
p "Destroyed all roles"


def create_users
    User.create(
        :first_name => "Meryl",
        :last_name => "Dominguez",
        :email => "meryl@email.com"
    )
    User.create(
        :first_name => "Aaron",
        :last_name => "Keeney",
        :email => "aaron@email.com",
    )
    User.create(
        :first_name => "Josh",
        :last_name => "Blue",
        :email => "josh@email.com",
    )
    User.create(
        :first_name => "Ash",
        :last_name => "Robillard",
        :email => "ash@email.com",
    )
    @user_meryl = User.find_by(first_name:"Meryl")
    @user_josh = User.find_by(first_name:"Josh")
    @user_ash = User.find_by(first_name:"Ash")
    p "Created new users"
end

def create_instruments
    Instrument.create(
        :name => "Piano"
    )
    Instrument.create(
        :name => "Voice, Soprano"
    )
    Instrument.create(
        :name => "Voice, Tenor"
    )
    Instrument.create(
        :name => "Violin"
    )
    Instrument.create(
        :name => "Bassoon"
    )
    @instrument_piano = Instrument.find_by(name:"Piano")
    @instrument_soprano = Instrument.find_by(name:"Voice, Soprano")
    @instrument_tenor = Instrument.find_by(name:"Voice, Tenor")
    @instrument_violin = Instrument.find_by(name:"Violin")
    p "Created new instruments"
end

def create_profiles
    Profile.create(
        :user=>  @user_meryl,
        :instrument => @instrument_soprano
    )
    Profile.create(
        :user =>  @user_meryl,
        :instrument => @instrument_violin
    )

    Profile.create(
        :user =>  @user_josh,
        :instrument => @instrument_piano
    )
    Profile.create(
        :user =>  @user_josh,
        :instrument => @instrument_tenor
    )

    Profile.create(
        :user =>  @user_ash,
        :instrument => @instrument_soprano
    )
    p "Created new profiles"
end

def create_roles
    @admin_role = Role.create(name: 'admin')
    @user_josh.roles << @admin_role
    @user_meryl.roles << @admin_role
    p "Created and assigned admin role"
end

create_users
create_instruments
create_profiles
create_roles


# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'confirmation' do
    let(:user) { create(:user) }
    let(:token) { user.generate_confirmation_token }

    let(:mail) { UserMailer.confirmation(user, token) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Confirmation Instructions')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([User::MAILER_FROM_EMAIL])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('THIS WILL EVENTUALLY SEND YOU TO A GET REQUEST page that confirms your email and sends a post request with the confirmation token')
      expect(mail.body.encoded).to include('Click here to confirm your email.')
    end
  end
end

namespace :vincular_contas do
  desc "TODO"
  task init: :environment do

    contatos = Contact.all
    contatos.each do |contato|
      contato.account = Account.find_by_name(contato.name_asso)
      contato.save
    end
  end

end

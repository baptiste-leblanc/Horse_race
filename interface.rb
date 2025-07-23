money_account = 100
horses = ['Caramel', 'Cisco', 'Pimprenelle', 'Spirit', 'Presto', 'Nash', "Hold'up", 'Quito', 'Clafoutis', 'Stewball']
horses_sampled = horses.sample(4)
puts 'Bienvenue dans le jeu de course de chevaux !'
gain = 0

# Ajout des statistiques
victories = 0
defeats = 0
total_gains = 0

# Ajout de l'historique et du compteur de victoires par cheval
history = []
horse_victories = Hash.new(0)

loop do
  # Affichage de l'argent et tirage des chevaux
  puts "\nVous avez actuellement #{money_account} €. 💶"
  horses_sampled = horses.sample(4)
  puts "Les chevaux en course sont : #{horses_sampled.join(', ')}"
  winner = horses_sampled.sample
  puts winner

  # Choix du joueur
  print "Sur quel cheval voulez-vous parier ?\n> "
  user_choice = gets.chomp.capitalize

  # Vérification du choix
  next puts("Ce cheval n'est pas dans la course. Essayez encore.") unless horses_sampled.include?(user_choice)

  # Choix de la mise
  print "Voulez-vous parier 5, 10, 15 ou 20 € sur ce cheval ?\n> "
  user_putting = gets.chomp.to_i
  unless [5, 10, 15, 20].include?(user_putting) && user_putting <= money_account
    puts "Mise invalide ou fonds insuffisants."
    next
  end

  # Course
  puts 'Les chevaux sont partis 🐴 !!'
  sleep(2)
  # Choix doubler la mise
  puts "A la mi-course, les deux chevaux en tête sont #{horses_sampled.sample(2).join(' et ')}"
  print 'Voulez-vous doubler votre mise ? o/n : '
  tricky_choice = gets.chomp
  sleep(1)
  puts "Les chevaux vont couper la ligne d'arrivée 🏁"
  sleep(1)

  # Résultat
  result = ''
  if tricky_choice == 'o' && winner == user_choice
    gain = user_putting * 10
    money_account = money_account + gain - user_putting
    victories += 1
    total_gains += gain
    horse_victories[user_choice] += 1
    result = 'Victoire (mise doublée)'
    puts "Vous aviez vu juste !! C'est bien #{user_choice} qui a gagné ! 🌟"
    puts "Vous avez gagné #{gain} € ! 🤑"
  elsif winner == user_choice
    gain = user_putting * 5
    money_account = money_account + gain - user_putting
    victories += 1
    total_gains += gain
    horse_victories[user_choice] += 1
    result = 'Victoire'
    puts "Vous aviez vu juste !! C'est bien #{user_choice} qui a gagné ! ⭐"
    puts "Vous avez gagné #{user_putting * 5} € ! 🤑"
  elsif tricky_choice == 'o' && winner != user_choice
    money_account -= user_putting.to_i * 2
    defeats += 1
    result = 'Défaite (mise doublée)'
    puts "Perdu ! C'est #{winner} qui a gagné. ❌"
    puts "Vous aviez parié #{user_putting * 2} € 😵"
  else
    money_account -= user_putting.to_i
    defeats += 1
    result = 'Défaite'
    puts "Perdu ! C'est #{winner} qui a gagné. ❌"
    puts "Vous aviez parié #{user_putting} € "
  end

  # Ajout à l'historique
  history << {
    cheval: user_choice,
    mise: user_putting,
    doublé: tricky_choice == 'o',
    gagnant: winner,
    résultat: result
  }

  # Fin ou continuer
  break puts "Vous n'avez plus d'argent. Fin de la partie. 💸" if money_account <= 0

  puts ''
  puts "Vous avez actuellement  #{money_account} € 💶"
  print 'Souhaitez-vous rejouer ? (o/n) : '

  break unless gets.chomp.downcase == 'o'
end

# Affichage des statistiques à la fin
puts "\nMerci d'avoir joué ! Vous repartez avec #{money_account} €. 💶"
puts 'Statistiques :'
puts "Victoires : #{victories} 🏆"
puts "Défaites : #{defeats} ❌"
puts "Gains totaux : #{total_gains} € 🤑"

# Affichage des victoires par cheval
puts "\nNombre de victoires par cheval :"
horse_victories.each do |pony, number|
  puts "#{pony} : #{number} victoire#{number > 1 ? 's' : ''}"
end

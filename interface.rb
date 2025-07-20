money_account = 100
horses = ["Caramel", "Cisco", "Pimprenelle", "Spirit", "Presto", "Nash", "Hold'up", "Quito", "Clafoutis", "Stewball"]
horses_sampled = horses.sample(4)
puts "Bienvenue dans le jeu de course de chevaux !"
gain = 0

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

  # Choix de la mise
  print "Voulez-vous parier 5, 10, 15 ou 20 € sur ce cheval ?\n> "
  user_putting = gets.chomp.to_i
  money_account -= user_putting

  # Vérification du choix
  next puts("Ce cheval n'est pas dans la course. Essayez encore.") unless horses_sampled.include?(user_choice)

  # Course
  puts "Les chevaux sont partis 🐴 !!"
  sleep(2)
  # Choix doubler la mise
  puts "A la mi-course, les deux chevaux en tête sont #{horses_sampled.sample(2).join(' et ')}"
  print "Voulez-vous doubler votre mise ? o/n : "
  tricky_choice = gets.chomp
  sleep(1)
  puts "Le cheval en tête va couper la ligne d'arrivée"
  sleep(1)

  # Résultat
  if tricky_choice == "o" && winner == user_choice
    money_account -= user_putting
    gain = user_putting * 10
    money_account += gain
    puts "Vous aviez vu juste !! C'est bien #{user_choice} qui a gagné ! 🌟"
    puts "Vous avez gagné #{gain} € ! 🤑"
  elsif winner == user_choice
    gain = user_putting * 5
    money_account += gain
    puts "Vous aviez vu juste !! C'est bien #{user_choice} qui a gagné ! ⭐"
    puts "Vous avez gagné #{user_putting * 5} € ! 🤑"
  elsif tricky_choice == "o" && winner != user_choice
    money_account -= user_putting.to_i * 2
    puts "Perdu ! C'est #{winner} qui a gagné. ❌"
    puts "Vous aviez parié #{user_putting * 2} € 😵"
  else
    money_account -= user_putting.to_i
    puts "Perdu ! C'est #{winner} qui a gagné. ❌"
    puts "Vous aviez parié #{user_putting} € "
  end

  # Fin ou continuer
  break puts "Vous n'avez plus d'argent. Fin de la partie. 💸" if money_account <= 0

  print "Souhaitez-vous rejouer ? (o/n) : "
  break unless gets.chomp.downcase == 'o'
end


puts "\nMerci d'avoir joué ! Vous repartez avec #{money_account} €."

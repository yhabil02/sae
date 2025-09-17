# Utilisation du script genmv1.sh

**Auteure :** Habil Yassmine 
**Date :** 12/09/2025

---

## Résumé
Ce document décrit le fonctionnement d’un script Bash permettant de créer, gérer et lister des machines virtuelles (VM) à l’aide de VirtualBox et de sa commande VBoxManage. Il inclut également la gestion automatique de métadonnées telles que la date de création et l’identité de l’utilisateur. Le script automatise les tâches de création, suppression, démarrage et arrêt de VM. Ce document couvre l’usage, les limites rencontrées ainsi que les choix techniques réalisés.

---

## Table des matières
1. Prérequis  
2. Syntaxe générale  
3. Paramètres modifiables  
4. Actions  
5. Problèmes rencontrés

---

## 1 - Prérequis
- VirtualBox installé sur la machine hôte.  
- `VBoxManage` accessible depuis le **PATH**.
- Compte utilisateur ayant droits pour écrire dans `~/VirtualBox VMs` et lancer VirtualBox.  
- Environnement : Linux / bash.  

---

## 2 - Syntaxe générale
./genmv1.sh <ACTION> [NOM_VM]

---

## 3 - Paramètres modifiables
Ces variables, placées au début du fichier genmv1.sh, définissent la configuration par défaut des VMs créées.
Vous pouvez les modifier selon vos besoins :

RAM=4096         
DISK_SIZE=65536 
OS_TYPE="Debian_64"
VM_BASE_DIR="$HOME/VirtualBox VMs"

---

## 4 - Actions
L: Lister les VMs et leurs métadonnées
N: Créer une nouvelle VM
S: Supprimer une VM
D: Démarrer une VM
A: Arrêter une VM

---

## 5 - Problèmes rencontrés
Le principal problème rencontré concerne la redirection des erreurs.
-Même en utilisant 2>/dev/null, certains warnings continuaient à apparaître dans le terminal.
-Résultat : lors de l’exécution, le script fonctionne bien, mais le terminal affiche encore des avertissements visuels.

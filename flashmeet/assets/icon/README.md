# 📱 Comment changer l'icône de l'app FlashMeet

## Étapes à suivre :

### 1. Prépare ton icône
- Crée une image PNG de **1024x1024 pixels** minimum
- Assure-toi que l'image est carrée
- Utilise un fond transparent si tu veux (pour iOS, il sera automatiquement rempli)
- Nomme ton fichier `app_icon.png`

### 2. Place ton icône
- Copie ton fichier `app_icon.png` dans le dossier :
  ```
  assets/icon/app_icon.png
  ```

### 3. Génère les icônes pour iOS et Android
Dans le terminal, exécute la commande :
```bash
flutter pub run flutter_launcher_icons
```

Cette commande va automatiquement :
- ✅ Créer toutes les tailles d'icônes nécessaires pour iOS (15 fichiers)
- ✅ Créer toutes les tailles d'icônes nécessaires pour Android (5 résolutions)
- ✅ Configurer les fichiers de métadonnées

### 4. Vérifie et teste
```bash
flutter run
```

L'icône de ton app sera mise à jour automatiquement !

## 🎨 Conseils pour une belle icône

- **Simple et reconnaissable** : L'icône doit être claire même en petite taille
- **Pas de texte** : Évite le texte, il devient illisible
- **Contraste élevé** : Utilise des couleurs contrastées
- **Cohérence** : Respecte le style de FlashMeet (moderne, flash, dynamique)

## 🔧 Configuration avancée

Le fichier `flutter_launcher_icons.yaml` permet de personnaliser :
- Icônes adaptatives Android (avec foreground/background séparés)
- Couleurs de fond
- Options de transparence

Pour plus d'options, consulte : https://pub.dev/packages/flutter_launcher_icons

---

**Note** : Après avoir généré les icônes, tu devras peut-être :
- Sur iOS : Nettoyer le build avec `flutter clean`
- Désinstaller et réinstaller l'app pour voir les changements


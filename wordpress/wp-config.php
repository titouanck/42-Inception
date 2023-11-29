<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier contient les réglages de configuration suivants : réglages MySQL,
 * préfixe de table, clés secrètes, langue utilisée, et ABSPATH.
 * Vous pouvez en savoir plus à leur sujet en allant sur
 * {@link https://fr.wordpress.org/support/article/editing-wp-config-php/ Modifier
 * wp-config.php}. C’est votre hébergeur qui doit vous donner vos
 * codes MySQL.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en "wp-config.php" et remplir les
 * valeurs.
 *
 * @link https://fr.wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', 'nom_de_ma_base');

/** Utilisateur de la base de données MySQL. */
define('DB_USER', 'utilisateur');

/** Mot de passe de la base de données MySQL. */
define('DB_PASSWORD', 'mot_de_passe');

/** Adresse de l’hébergement MySQL. */
define('DB_HOST', 'localhost:3306');

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8');

/** Type de collation de la base de données.
  * N’y touchez que si vous savez ce que vous faites.
  */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clés secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'PxIM;L3+Xm,:%jz_5q,qK2zn+-Hc^.|>1Dd|XDF i8y]GYE},YUJgj,Cbw4%B1cf');
define('SECURE_AUTH_KEY',  '0dF*8#F0r }Wu.YSme!-shqs8_q+i$uc-7<E?@BQHPWY8.dt<z9N?(x3B5ayMT2K');
define('LOGGED_IN_KEY',    '6y#^`FE aiR@d#~V Aorh6G+ 2{Xcd9B`K{v|r]kB{+w,-P8o?PFH2G|97x{3VGW');
define('NONCE_KEY',        'CF>iK4.V@u&U@B!U8wcdo,X*:Z70BWr.]do$<:pWZ5Z6t;{ev#zm|Eichx2ZK+mX');
define('AUTH_SALT',        '%}TH-?G|Q?At%[?L]jVi^Q@un0UA/1KxuX<DK4od,l3U:e-$aXHSF!i>Oacop--!');
define('SECURE_AUTH_SALT', 'iHsy6:K`a14)U`q4rNMvG{28y.pqg3!EmK#r|Ss2U-<~eLS?D;*=;-9;+`Y|_aMP');
define('LOGGED_IN_SALT',   'fx.V ~J.<+8ni@qxjRpq~w!iOjQj640j9`1M47axx.cdvo5eUfi/RY[f<|Mh)>[0');
define('NONCE_SALT',       'M<K|F0K 8_sAeWsV:Z)ejZQp-1Q@QhWN?+-AUu-^,>-37A-/9~Du7olc^1s0.;,5');
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs et développeuses : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortement recommandé que les développeurs et développeuses d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur la documentation.
 *
 * @link https://fr.wordpress.org/support/article/debugging-in-wordpress/
 */
define('WP_DEBUG', false);

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');

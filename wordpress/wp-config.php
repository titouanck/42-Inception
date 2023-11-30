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
define( 'DB_NAME', 'ticodb' );

/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'tico45' );

/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'tico45' );

/** Adresse de l’hébergement MySQL. */
define( 'DB_HOST', '172.29.0.2:3306' );

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define( 'DB_CHARSET', 'utf8mb4' );

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
define( 'AUTH_KEY',         '7Rf^B?WH8>WOobNrsNZIU!]F#3aL>ncp}gBdbzRECX2Ar^V,V>S`q~W+ln;|Xxx^' );
define( 'SECURE_AUTH_KEY',  'I3NFBO+z@@wVXxTam&@k6T2kXYLi2oP7MDZszY*R`=d9Z_HWCYl7;ZCal5[uDEoY' );
define( 'LOGGED_IN_KEY',    '1w8.FOO$6G=wOU|OMRHlx7Pl|]m,pb~#tgcrvq?3I YkgF{[8m7iXYnO]-.d#cYZ' );
define( 'NONCE_KEY',        'L5{uz~.8$<x<SwLWRNkmAed?/d2.Bd}50d@s1{l UTI3*eur{+[x?xi2:#2{_`jB' );
define( 'AUTH_SALT',        '1iQI4p<0l&>9SA%qLn<k}Vf#eA#Q;LeSs(+T(1_g(-*~DinO$9:zD0]QG}5g]E>v' );
define( 'SECURE_AUTH_SALT', 'D&MCe,;A8`@ep}sIWR4Q@tZha+0dU~jp*q,/&8Jfl}Z{p0SV<^B`A?hT j!jom-6' );
define( 'LOGGED_IN_SALT',   'Nv;evhvOIjhI/~v9kWf;~lqr6hMgVFlm$n?TCpi~x=)n9nTF-zPWn3[xB`g&WPi6' );
define( 'NONCE_SALT',       'jE#0 ,Lgm|nrw!,m9>u<Q2&pD6yz,-hxM4;5nC}-{ 2~;;7Uf3R~4F?5^&Va?VW*' );
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

<?php
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
require_once __DIR__.'/config.php';
date_default_timezone_set(APP_TIMEZONE);
try {
  $pdo = new PDO('mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset=utf8mb4', DB_USER, DB_PASS, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
  ]);
} catch (Throwable $e) {
  http_response_code(500);
  exit('Database connection failed. Check includes/config.php and import database/schema.sql.');
}
function h($v){ return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
function redirect($to){ header('Location: '.$to); exit; }
function is_logged_in(){ return !empty($_SESSION['user_id']); }
function require_login(){ if(!is_logged_in()) redirect('login.php'); }
function current_user(){ return ['id'=>$_SESSION['user_id']??0,'name'=>$_SESSION['user_name']??'','role'=>$_SESSION['user_role']??'staff']; }
function csrf_token(){ if(empty($_SESSION['csrf'])) $_SESSION['csrf']=bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function verify_csrf(){ if($_SERVER['REQUEST_METHOD']==='POST' && !hash_equals($_SESSION['csrf']??'', $_POST['csrf']??'')){ http_response_code(419); exit('Session token expired. Refresh and try again.'); } }
function money($n){ return '₹'.number_format((float)$n,2); }
function flash($message,$type='success'){ $_SESSION['flash']=['message'=>$message,'type'=>$type]; }
function take_flash(){ $f=$_SESSION['flash']??null; unset($_SESSION['flash']); return $f; }
function layout_start($title='Dashboard',$active='dashboard'){
  $u=current_user(); $f=take_flash(); ?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><?=h($title)?> · <?=h(APP_NAME)?></title><link rel="preconnect" href="https://fonts.googleapis.com"><link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet"><link rel="stylesheet" href="assets/css/app.css"></head><body>
<div class="app-shell"><aside class="sidebar" id="sidebar"><a class="brand" href="dashboard.php"><span class="brand-mark">A</span><span><b>AquaDesk</b><small>POOL MANAGEMENT</small></span></a><div class="nav-label">WORKSPACE</div><nav>
<a class="<?= $active==='dashboard'?'active':''?>" href="dashboard.php"><span>◫</span> Overview</a>
<a class="<?= $active==='pos'?'active':''?>" href="pos.php"><span>＋</span> Point of sale <em>POS</em></a>
<a class="<?= $active==='customers'?'active':''?>" href="customers.php"><span>♙</span> Customers</a>
<a class="<?= $active==='swimmers'?'active':''?>" href="swimmers.php"><span>◷</span> Swim sessions</a>
<a class="<?= $active==='bookings'?'active':''?>" href="bookings.php"><span>▦</span> Bookings</a>
<a class="<?= $active==='inventory'?'active':''?>" href="inventory.php"><span>▤</span> Inventory</a>
<a class="<?= $active==='sales'?'active':''?>" href="sales.php"><span>↗</span> Sales & bills</a>
</nav><div class="nav-label">SYSTEM</div><nav><a href="reports.php" class="<?= $active==='reports'?'active':''?>"><span>▥</span> Reports</a><?php if($u['role']==='admin'):?><a href="staff.php" class="<?= $active==='staff'?'active':''?>"><span>♧</span> Staff accounts</a><?php endif;?></nav><div class="sidebar-bottom"><div class="profile-chip"><span class="avatar"><?=h(strtoupper(substr($u['name'],0,1)))?></span><span><b><?=h($u['name'])?></b><small><?=h(ucfirst($u['role']))?></small></span></div><a class="logout" href="logout.php">↗ Sign out</a></div></aside><main class="main-area"><header class="topbar"><button class="menu-btn" id="menuBtn" aria-label="Open menu">☰</button><div><div class="eyebrow">AQUADESK / <?=h(strtoupper($title))?></div><h1><?=h($title)?></h1></div><div class="topbar-right"><span class="status-pill"><i></i> System online</span><span class="today"><?=date('D, d M Y')?></span></div></header><section class="content">
<?php if($f):?><div class="alert <?=h($f['type'])?>"><?=h($f['message'])?></div><?php endif;
}
function layout_end(){ ?><footer class="footer"><span>© <?=date('Y')?> AquaDesk Pool POS</span><span>Built for smooth operations <b>●</b></span></footer></section></main></div><script src="assets/js/app.js"></script></body></html><?php }
function admin_only(){ if((current_user()['role']??'')!=='admin'){ http_response_code(403); exit('Admin access required.'); } }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:control_app/config/routes/route_names.dart';
import 'package:control_app/core/api/api_constant.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/bounce_tap.dart';
import '../widgets/floating_bottom_nav_bar.dart';
import '../widgets/home_tab.dart';
import '../widgets/tv_screen_tab.dart';
import '../widgets/remote_tab.dart';
import '../widgets/settings_tab.dart';

// ─── Design Tokens ────────────────────────────────────────────────
const _kBg = Color(0xFFE8EAD8);
const _kDark = Color(0xFF1A1E17);
const _kMuted = Color(0xFF9E9E8E);

class SmartTvControlPage extends StatefulWidget {
  final String name;
  final String? profilePictureUrl;
  final String email;

  const SmartTvControlPage({
    super.key,
    this.name = 'Abdalrhman reda',
    this.profilePictureUrl,
    this.email = '',
  });

  @override
  State<SmartTvControlPage> createState() => _SmartTvControlPageState();
}

class _SmartTvControlPageState extends State<SmartTvControlPage> {
  // ── Shared state ──────────────────────────────────────────────
  String _selectedRoom = 'Living Room';
  bool _isTvOn = true;
  bool _isAcOn = true;
  bool _isLightsOn = false;
  bool _isSecurityOn = true;
  double _volume = 26;
  bool _isPlaying = false;
  int _selectedNavIndex = 2;

  // TV Screen state
  int _selectedInput = 0;
  int _selectedPictureMode = 0;
  int _brightness = 70;
  int _contrast = 60;
  int _channel = 12;

  // Settings state
  bool _sleepTimerOn = false;
  int _sleepMins = 30;
  int _selectedSoundMode = 0;

  late PageController _pageController;

  final List<String> _rooms = ['Living Room', 'Kitchen', 'Bathroom'];
  final List<String> _inputs = ['HDMI 1', 'HDMI 2', 'AV', 'TV'];
  final List<String> _pictureModes = ['Standard', 'Movie', 'Game', 'Vivid'];
  final List<String> _soundModes = ['Standard', 'Cinema', 'Music', 'Sports'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedNavIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _togglePower() {
    setState(() => _isTvOn = !_isTvOn);
  }

  void _onNavTap(int index) {
    setState(() => _selectedNavIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeTab(
                  rooms: _rooms,
                  selectedRoom: _selectedRoom,
                  onRoomSelected: (r) => setState(() => _selectedRoom = r),
                  userName: widget.name,
                  userEmail: widget.email,
                  greeting: _getGreeting(),
                  isTvOn: _isTvOn,
                  onToggleTv: _togglePower,
                  isAcOn: _isAcOn,
                  onToggleAc: () => setState(() => _isAcOn = !_isAcOn),
                  isLightsOn: _isLightsOn,
                  onToggleLights: () => setState(() => _isLightsOn = !_isLightsOn),
                  isSecurityOn: _isSecurityOn,
                  onToggleSecurity: () => setState(() => _isSecurityOn = !_isSecurityOn),
                ),
                TvScreenTab(
                  isTvOn: _isTvOn,
                  isPlaying: _isPlaying,
                  channel: _channel,
                  selectedInput: _selectedInput,
                  volume: _volume,
                  inputs: _inputs,
                  pictureModes: _pictureModes,
                  selectedPictureMode: _selectedPictureMode,
                  brightness: _brightness,
                  contrast: _contrast,
                  onTogglePower: _togglePower,
                  onTogglePlay: () => setState(() => _isPlaying = !_isPlaying),
                  onInputChanged: (i) => setState(() => _selectedInput = i),
                  onPictureModeChanged: (i) => setState(() => _selectedPictureMode = i),
                  onChannelChanged: (ch) => setState(() => _channel = ch),
                  onBrightnessChanged: (v) => setState(() => _brightness = v),
                  onContrastChanged: (v) => setState(() => _contrast = v),
                ),
                RemoteTab(
                  rooms: _rooms,
                  selectedRoom: _selectedRoom,
                  onRoomSelected: (r) => setState(() => _selectedRoom = r),
                  isTvOn: _isTvOn,
                  isPlaying: _isPlaying,
                  volume: _volume,
                  onTogglePower: _togglePower,
                  onTogglePlay: () => setState(() => _isPlaying = !_isPlaying),
                  onVolumeChanged: (v) => setState(() => _volume = v),
                  onDirectionPressed: (dir) => _toast('D-Pad: $dir'),
                  onBackPressed: () => _toast('Back'),
                  onHomePressed: () => _toast('Home'),
                  onRewindPressed: () => _toast('Rewind'),
                  onFastForwardPressed: () => _toast('Fast Forward'),
                  onCameraTap: () => Navigator.pushNamed(context, RouteNames.entranceCamera),
                ),
                SettingsTab(
                  soundModes: _soundModes,
                  selectedSoundMode: _selectedSoundMode,
                  onSoundModeChanged: (i) => setState(() => _selectedSoundMode = i),
                  sleepTimerOn: _sleepTimerOn,
                  onSleepTimerToggle: (v) => setState(() => _sleepTimerOn = v),
                  sleepMins: _sleepMins,
                  onSleepMinsChanged: (v) => setState(() => _sleepMins = v),
                  onTileTap: _toast,
                ),
              ],
            ),

            // Persistent header
            Positioned(
              top: 16.h,
              left: 20.w,
              right: 20.w,
              child: AnimatedEntrance(
                duration: const Duration(milliseconds: 600),
                offset: const Offset(0, -0.18),
                child: _buildHeader(),
              ),
            ),

            // Floating Bottom Nav
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 28.h,
              child: AnimatedEntrance(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 700),
                offset: const Offset(0, 0.4),
                child: FloatingBottomNavBar(
                  selectedIndex: _selectedNavIndex,
                  onIndexSelected: _onNavTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  //  SHARED HEADER
  // ══════════════════════════════════════════════════════════════════
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildHeaderAvatar(),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: _kDark,
                  ),
                ),
                if (widget.email.isNotEmpty)
                  Text(
                    widget.email,
                    style: GoogleFonts.urbanist(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: _kMuted,
                    ),
                  ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _headerIconBtn(
              icon: Iconsax.element_4_copy,
              onTap: () => _toast('Menu'),
            ),
            SizedBox(width: 10.w),
            _headerBellBtn(),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderAvatar() {
    ImageProvider imageProvider;
    final url = widget.profilePictureUrl;

    if (url != null && url.isNotEmpty) {
      String fullUrl = url;
      if (url.startsWith('/')) {
        fullUrl = '${ApiConstant.baseUrl}${url.substring(1)}';
      } else if (!url.startsWith('http')) {
        fullUrl = '${ApiConstant.baseUrl}$url';
      }
      imageProvider = NetworkImage(fullUrl);
    } else {
      imageProvider = const AssetImage('assets/images/user_avatar.png');
    }

    return Container(
      width: 46.w,
      height: 46.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image(
          image: imageProvider,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Image(
              image: AssetImage('assets/images/user_avatar.png'),
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  Widget _headerIconBtn({required IconData icon, required VoidCallback onTap}) {
    return BounceTap(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _kDark, size: 20.sp),
      ),
    );
  }

  Widget _headerBellBtn() {
    return BounceTap(
      onTap: () => _toast('Notifications'),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Iconsax.notification_copy, color: _kDark, size: 20.sp),
          ),
          Positioned(
            top: 1,
            right: 1,
            child: Container(
              width: 9.w,
              height: 9.w,
              decoration: const BoxDecoration(
                color: Color(0xFFE05252),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Toast ──────────────────────────────────────────────────────
  void _toast(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: GoogleFonts.urbanist(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _kDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 100.h),
      ),
    );
  }
}

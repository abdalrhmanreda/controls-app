import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:control_app/config/routes/route_names.dart';
import 'package:control_app/core/api/api_constant.dart';
import '../widgets/room_selector.dart';
import '../widgets/volume_slider.dart';
import '../widgets/tv_dpad.dart';
import '../widgets/device_preview_card.dart';
import '../widgets/floating_bottom_nav_bar.dart';
import '../widgets/device_toggle_card.dart';
import '../widgets/smart_toggle_switch.dart';
import '../widgets/channel_selector.dart';
import '../widgets/tv_screen_card.dart';
import '../widgets/slider_card.dart';

// ─── Design Tokens ────────────────────────────────────────────────
const _kBg = Color(0xFFE8EAD8);
const _kDark = Color(0xFF1A1E17);
const _kGreen = Color(0xFFA8C37A);
const _kGreenDot = Color(0xFF8FBF5A);
const _kSurface = Color(0xFFF2F3ED);
const _kMuted = Color(0xFF9E9E8E);

class SmartTvControlPage extends StatefulWidget {
  final String name;
  final String? profilePictureUrl;
  final String email;

  const SmartTvControlPage({
    super.key,
    this.name = 'User',
    this.profilePictureUrl,
    this.email = '',
  });

  @override
  State<SmartTvControlPage> createState() => _SmartTvControlPageState();
}

class _SmartTvControlPageState extends State<SmartTvControlPage>
    with TickerProviderStateMixin {
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

  late AnimationController _powerAnim;
  late Animation<double> _powerScale;
  late PageController _pageController;

  final List<String> _rooms = ['Living Room', 'Kitchen', 'Bathroom'];
  final List<String> _inputs = ['HDMI 1', 'HDMI 2', 'AV', 'TV'];
  final List<String> _pictureModes = ['Standard', 'Movie', 'Game', 'Vivid'];
  final List<String> _soundModes = ['Standard', 'Cinema', 'Music', 'Sports'];

  @override
  void initState() {
    super.initState();
    _powerAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _powerScale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _powerAnim, curve: Curves.easeInOut),
    );
    _pageController = PageController(initialPage: _selectedNavIndex);
  }

  @override
  void dispose() {
    _powerAnim.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _togglePower() async {
    await _powerAnim.forward();
    await _powerAnim.reverse();
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

  // ─────────────────────────────────────────────────────────────────
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
                _buildHomePage(),
                _buildTvScreenPage(),
                _buildRemotePage(),
                _buildSettingsPage(),
              ],
            ),

            // Persistent header
            Positioned(
              top: 16.h,
              left: 20.w,
              right: 20.w,
              child: _buildHeader(),
            ),

            // Floating Bottom Nav
            Positioned(
              left: 20.w,
              right: 20.w,
              bottom: 28.h,
              child: FloatingBottomNavBar(
                selectedIndex: _selectedNavIndex,
                onIndexSelected: _onNavTap,
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
            _headerIconBtn(icon: Iconsax.element_4_copy, onTap: () => _toast('Menu')),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Icon(icon, color: _kDark, size: 20.sp),
      ),
    );
  }

  Widget _headerBellBtn() {
    return GestureDetector(
      onTap: () => _toast('Notifications'),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration:
                const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Iconsax.notification_copy, color: _kDark, size: 20.sp),
          ),
          Positioned(
            top: 1,
            right: 1,
            child: Container(
              width: 9.w,
              height: 9.w,
              decoration: const BoxDecoration(
                  color: Color(0xFFE05252), shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  //  TAB 0 – HOME
  // ══════════════════════════════════════════════════════════════════
  Widget _buildHomePage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          left: 20.w, right: 20.w, top: 80.h, bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          RoomSelector(
            rooms: _rooms,
            selectedRoom: _selectedRoom,
            onRoomSelected: (r) => setState(() => _selectedRoom = r),
          ),
          SizedBox(height: 22.h),

          // Welcome card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1E17), Color(0xFF2D3828)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_getGreeting()},',
                        style: GoogleFonts.urbanist(
                            fontSize: 13.sp, color: Colors.white60),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.name,
                        style: GoogleFonts.urbanist(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      if (widget.email.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          widget.email,
                          style: GoogleFonts.urbanist(
                            fontSize: 12.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                      SizedBox(height: 10.h),
                      _statusChip(
                        icon: Iconsax.electricity_copy,
                        label: '3 devices on',
                        color: _kGreen,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: _kGreen.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Iconsax.home_2_copy, color: _kGreen, size: 30.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          Text(
            'Quick Controls',
            style: GoogleFonts.urbanist(
              fontSize: 16.sp, fontWeight: FontWeight.w700, color: _kDark,
            ),
          ),
          SizedBox(height: 14.h),

          // ── DeviceToggleCard grid ─────────────────────────────────
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.55,
            children: [
              DeviceToggleCard(
                icon: Iconsax.monitor_copy,
                label: 'Smart TV',
                isOn: _isTvOn,
                color: _kGreen,
                onTap: _togglePower,
              ),
              DeviceToggleCard(
                icon: Iconsax.wind_2_copy,
                label: 'AC',
                isOn: _isAcOn,
                color: const Color(0xFF6FB4D6),
                onTap: () => setState(() => _isAcOn = !_isAcOn),
              ),
              DeviceToggleCard(
                icon: Iconsax.flash_circle_copy,
                label: 'Lights',
                isOn: _isLightsOn,
                color: const Color(0xFFE5C17C),
                onTap: () => setState(() => _isLightsOn = !_isLightsOn),
              ),
              DeviceToggleCard(
                icon: Iconsax.security_safe_copy,
                label: 'Security',
                isOn: _isSecurityOn,
                color: const Color(0xFFD47B72),
                onTap: () => setState(() => _isSecurityOn = !_isSecurityOn),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          Row(
            children: [
              const Expanded(child: ClimateCard()),
              SizedBox(width: 14.w),
              Expanded(
                child: CameraCard(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.entranceCamera),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.urbanist(
                fontSize: 11.sp, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  //  TAB 1 – TV SCREEN
  // ══════════════════════════════════════════════════════════════════
  Widget _buildTvScreenPage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          left: 20.w, right: 20.w, top: 80.h, bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),

          // ── TvScreenCard ─────────────────────────────────────────
          TvScreenCard(
            isOn: _isTvOn,
            isPlaying: _isPlaying,
            channel: _channel,
            selectedInput: _selectedInput,
            volume: _volume,
            inputs: _inputs,
            onTogglePower: _togglePower,
            onTogglePlay: () => setState(() => _isPlaying = !_isPlaying),
          ),
          SizedBox(height: 20.h),

          // Power row with SmartToggleSwitch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TV Power',
                style: GoogleFonts.urbanist(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: _kDark,
                ),
              ),
              SmartToggleSwitch(
                isOn: _isTvOn,
                activeColor: _kGreen,
                onChanged: (_) => _togglePower(),
              ),
            ],
          ),
          SizedBox(height: 18.h),

          // Input Source
          Text(
            'Input Source',
            style: GoogleFonts.urbanist(
              fontSize: 13.sp, fontWeight: FontWeight.w600, color: _kMuted,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 44.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _inputs.length,
              itemBuilder: (_, i) {
                final selected = i == _selectedInput;
                return GestureDetector(
                  onTap: () => setState(() => _selectedInput = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: selected ? _kDark : Colors.white,
                      borderRadius: BorderRadius.circular(22.r),
                      boxShadow: selected
                          ? [BoxShadow(color: _kDark.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        _inputs[i],
                        style: GoogleFonts.urbanist(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : _kDark,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 18.h),

          // Picture Mode
          Text(
            'Picture Mode',
            style: GoogleFonts.urbanist(
              fontSize: 13.sp, fontWeight: FontWeight.w600, color: _kMuted,
            ),
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pictureModes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.w,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (_, i) {
              final selected = i == _selectedPictureMode;
              return GestureDetector(
                onTap: () => setState(() => _selectedPictureMode = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: selected ? _kDark : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: selected
                        ? [BoxShadow(color: _kDark.withValues(alpha: 0.18), blurRadius: 8, offset: const Offset(0, 3))]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      _pictureModes[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : _kDark,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 18.h),

          // ── ChannelSelector ──────────────────────────────────────
          ChannelSelector(
            channel: _channel,
            onIncrement: () =>
                setState(() => _channel = (_channel + 1).clamp(1, 999)),
            onDecrement: () =>
                setState(() => _channel = (_channel - 1).clamp(1, 999)),
          ),
          SizedBox(height: 14.h),

          // ── SliderCards ──────────────────────────────────────────
          SliderCard(
            label: 'Brightness',
            icon: Iconsax.sun_1_copy,
            value: _brightness,
            onChanged: (v) => setState(() => _brightness = v),
          ),
          SizedBox(height: 12.h),
          SliderCard(
            label: 'Contrast',
            icon: Iconsax.sun_fog_copy,
            value: _contrast,
            onChanged: (v) => setState(() => _contrast = v),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  //  TAB 2 – REMOTE
  // ══════════════════════════════════════════════════════════════════
  Widget _buildRemotePage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          left: 20.w, right: 20.w, top: 80.h, bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          RoomSelector(
            rooms: _rooms,
            selectedRoom: _selectedRoom,
            onRoomSelected: (r) => setState(() => _selectedRoom = r),
          ),
          SizedBox(height: 22.h),
          _buildTvControlCard(),
          SizedBox(height: 18.h),
          Row(
            children: [
              const Expanded(child: ClimateCard()),
              SizedBox(width: 14.w),
              Expanded(
                child: CameraCard(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.entranceCamera),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTvControlCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Smart TV Control',
            style: GoogleFonts.urbanist(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              color: _kDark,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(height: 22.h),

          // ── Power button ─────────────────────────────────────────
          ScaleTransition(
            scale: _powerScale,
            child: GestureDetector(
              onTap: _togglePower,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: 62.w,
                height: 62.w,
                decoration: BoxDecoration(
                  color: _isTvOn ? _kDark : _kSurface,
                  shape: BoxShape.circle,
                  boxShadow: _isTvOn
                      ? [
                          BoxShadow(
                            color: _kDark.withValues(alpha: 0.30),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Iconsax.flash_circle_copy,
                  color: _isTvOn ? _kGreen : _kMuted,
                  size: 26.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 22.h),

          // Back / D-pad / Home
          AnimatedOpacity(
            opacity: _isTvOn ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: AbsorbPointer(
              absorbing: !_isTvOn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _controlBtn(
                      icon: Iconsax.undo_copy, onTap: () => _toast('Back')),
                  TvDpad(
                      onDirectionPressed: (dir) => _toast('D-Pad: $dir')),
                  _controlBtn(
                      icon: Iconsax.home_copy, onTap: () => _toast('Home')),
                ],
              ),
            ),
          ),
          SizedBox(height: 22.h),

          // Media row
          AnimatedOpacity(
            opacity: _isTvOn ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: AbsorbPointer(
              absorbing: !_isTvOn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _controlBtn(
                      icon: Iconsax.previous_copy,
                      onTap: () => _toast('Rewind')),
                  SizedBox(width: 26.w),
                  _playPauseBtn(),
                  SizedBox(width: 26.w),
                  _controlBtn(
                      icon: Iconsax.next_copy,
                      onTap: () => _toast('Fast Forward')),
                ],
              ),
            ),
          ),
          SizedBox(height: 26.h),

          // Volume
          AnimatedOpacity(
            opacity: _isTvOn ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: AbsorbPointer(
              absorbing: !_isTvOn,
              child: VolumeSlider(
                volume: _volume,
                isEnabled: _isTvOn,
                onVolumeChanged: (v) => setState(() => _volume = v),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(icon, color: _kDark, size: 20.sp),
      ),
    );
  }

  Widget _playPauseBtn() {
    return GestureDetector(
      onTap: () => setState(() => _isPlaying = !_isPlaying),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 62.w,
        height: 62.w,
        decoration: BoxDecoration(
          color: _kGreen,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _kGreen.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          _isPlaying ? Iconsax.pause_copy : Iconsax.play_copy,
          color: Colors.white,
          size: 28.sp,
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  //  TAB 3 – SETTINGS
  // ══════════════════════════════════════════════════════════════════
  Widget _buildSettingsPage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          left: 20.w, right: 20.w, top: 80.h, bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text(
            'Settings',
            style: GoogleFonts.urbanist(
              fontSize: 22.sp, fontWeight: FontWeight.w800, color: _kDark,
            ),
          ),
          SizedBox(height: 20.h),

          // Sound mode
          _settingsSection(
            title: 'Sound Mode',
            child: Wrap(
              spacing: 8.w,
              children: List.generate(_soundModes.length, (i) {
                final selected = i == _selectedSoundMode;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSoundMode = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 9.h),
                    decoration: BoxDecoration(
                      color: selected ? _kDark : _kSurface,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: selected
                          ? [BoxShadow(color: _kDark.withValues(alpha: 0.18), blurRadius: 8, offset: const Offset(0, 3))]
                          : [],
                    ),
                    child: Text(
                      _soundModes[i],
                      style: GoogleFonts.urbanist(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.white : _kDark,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 12.h),

          // Sleep Timer with SmartToggleSwitch
          _settingsSection(
            title: 'Sleep Timer',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _sleepTimerOn ? '$_sleepMins minutes' : 'Disabled',
                      style: GoogleFonts.urbanist(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: _kMuted,
                      ),
                    ),
                    // ── SmartToggleSwitch ─────────────────────────
                    SmartToggleSwitch(
                      isOn: _sleepTimerOn,
                      activeColor: _kGreenDot,
                      onChanged: (v) =>
                          setState(() => _sleepTimerOn = v),
                    ),
                  ],
                ),
                if (_sleepTimerOn) ...[
                  SizedBox(height: 10.h),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: _kDark,
                      inactiveTrackColor: _kSurface,
                      thumbColor: _kDark,
                      overlayColor: _kDark.withValues(alpha: 0.1),
                      trackHeight: 4.h,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 8.r),
                    ),
                    child: Slider(
                      value: _sleepMins.toDouble(),
                      min: 10,
                      max: 120,
                      divisions: 11,
                      onChanged: (v) =>
                          setState(() => _sleepMins = v.toInt()),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Info tiles using SettingsTile
          ...[
            ('Display Name', 'Living Room TV', Iconsax.monitor_copy),
            ('Resolution', '4K Ultra HD', Iconsax.cpu_setting_copy),
            ('Network', 'Connected • WiFi', Iconsax.wifi_copy),
            ('Software', 'v3.2.1 (Latest)', Iconsax.info_circle_copy),
          ].map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: SettingsTile(
                label: item.$1,
                value: item.$2,
                icon: item.$3,
                onTap: () => _toast(item.$1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
              fontSize: 13.sp, fontWeight: FontWeight.w600, color: _kMuted,
            ),
          ),
          SizedBox(height: 12.h),
          child,
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
              color: Colors.white, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _kDark,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 100.h),
      ),
    );
  }
}

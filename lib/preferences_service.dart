import 'package:ban_sach/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService{
  Future  saveSettings(Setting setting) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('revenue', setting.revenue);
    await preferences.setInt('customer', setting.customer);
    await preferences.setInt('customerVip', setting.customerVip);
    print('Saved setting');
  }
  Future <Setting> getSetting() async{
    final preferences =await SharedPreferences.getInstance();

    final revenue =preferences.getInt('revenue') ?? 0;
    final customer =preferences.getInt('customer') ?? 0;
    final customerVip =preferences.getInt('customerVip') ?? 0;
    return Setting(revenue: revenue , customer: customer , customerVip: customerVip );
  }
}
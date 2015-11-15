//
//  ViewController.m
//  ArticleManagement
//
//  Created by Yin Kokpheng on 11/12/15.
//  Copyright © 2015 Yin Kokpheng. All rights reserved.
//

#import "ViewController.h"
#import "Article.h"
#import "ArticleDetailsViewController.h"
#import "ArticleDetailsNoImageViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController


NSMutableArray *articleArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
  
    Article *art1 = [[Article alloc]initWithTitle:@"Cydia Substrate ចេញ​កំណែ​ទម្រង់​ថ្មី​ហើយ ដូច្នេះ Tweak ចាស់ៗ​មួយ​ចំនួន​ធំ​អាច​ដំណើរ​ការ​លើ iOS 9" Content:@"លោក Saurik បាន​បញ្ចេញ Cydia Substrate ជំនាន់ថ្មី ហើយដើម្បីស្រប តាមតម្រូវការ អ្នកបង្កើត Tweak មួយចំនួន និងដើម្បី ទៅកែប្រព័ន្ធ ប្រតិបត្តិការ iOS 9 អោយវាអាច ដំណើរការ Tweak ចាស់ៗមួយចំនួនធំ ផងដែរ។\n\nមកទល់ពេលនេះ អ្នកអាច Update Cydia ទៅកាន់ ជំនាន់ 0.9.6110 បានហើយ​ ប្រសិនបើអ្នក មិនទាន់ Update ទេ សូមភ្ជាប់ ទៅកាន់ អ៊ីនធើណែត និង ចូលទៅ Cydia ធ្វើការ Refresh រួច Update វាជាបន្ទាន់។ រឿង Update Cydia Substrate មិនអាច អាក់ខាន បានឡើយ ព្រោះ Cydia Substrate វាជាផ្នែកមួយ ដ៏ធំ ជួយអោយ ដំណើរការ Tweak ក្រោយពេលដែល Jailbreak រួចរាល់ ប្រសិនបើ វាមានបញ្ហា វាអាច បណ្តាលអោយ ខូចប្រព័ន្ធ ប្រតិបត្តិការ របស់អ្នក ផងដែរ។\n\n យើងជឿជាក់ថា កំណែទម្រង់ Cydia Substrate ជំនាន់ថ្មីនេះ វានឹងជួយ សម្រួលការងារ ច្រើនដល់ប្រព័ន្ធ ប្រតិបត្តិការអ្នក រួមទាំង ផ្តល់ភាព ងាយស្រួលដល់ អ្នកបង្កើត Tweak ផងដែរ។ ប្រសិនបើអ្នក ចង់ព្យាយាម តម្លើង Tweak ចាស់ៗ អ្នកអាច សាកល្បងបាន តែគួរទុក ចិត្តថា Tweak នោះ វាមិន ចាស់ខ្លាំងពេក ប្រសិនបើវា ធ្លាប់ដំណើរ ការលើ iOS 8 អ្នកអាច ព្យាយាមបាន តែមាន]ការ ទទួលខុស ត្រូវដោយខ្លួនឯង។" ImagePath:@"article1.jpg"];
    
    
    Article *art2 = [[Article alloc]initWithTitle:@"បង្កើត​ទីក្រុង ពោរ​ពេញ​ដោយ​ភាព​ស្រស់​បំព្រង​ជាមួយ​ហ្គេម​កសិដ្ឋាន​ចេញថ្មី Everytown!" Content:@"កាលពីប៉ុន្មាន សប្តាហ៍មុន ខេមបូ បាន​លើក​យក កសិដ្ឋាន​ថ្មីមួយ ដែល​មាន​ឈ្មោះ Farm Away ហើយ​វា​អាច​ដំណើរ​ការ បាន​តែ​សំរាប់ ប្រព័ន្ធ​ប្រតិបត្តិការ iOS តែប៉ុណ្ណោះ រីឯប្រព័ន្ធដទៃ ផ្សេងទៀត នៅ​ពុំ​ទាន់​អាច​ដំណើរការ បាននោះទេ។ \n\n ដោយឡែក មានហ្គេម កសិដ្ឋានមួយ ដែលទើបនឹង ចេញថ្មីដែរ មានឈ្មោះថា Everytown ប៉ុន្តែពិសេស​ជាង ដោយមានសាងសង់ ឧបករណ៍ផលិត អាហារ, ដាក់ចំណីអោយ សត្វចិញ្ចឹម, ដាំបន្លែ, រៀប​ចំ​ទីក្រុង​មួយ និងអោយមាន រចនាបថ សោភណ័ភាព ស្រស់ស្អាត និងដទៃទៀត ជាច្រើន។" ImagePath:@"article2.jpg"];
    
    
    Article *art3 = [[Article alloc]initWithTitle:@"រឿង Divergent ប្រភេទ​រឿង​បាញ់​ប្រហារ, អភិនីហា និង​ការ​ស្រម៉ៃ​ខ្ពស់ បាន​ចេញ​ឈុត​ខ្លី​វគ្គ​ថ្មី​ដំបូងហើយ!" Content:@"នេះជាឈុតខ្លីដំបូង ដែលជាវគ្គបន្ទាប់ របស់រឿង Divergent ដែលយើង បានដឹងថា ជារឿងបែប ស្មុគស្មាញ, បរិយាយពី ភាពប្រឌិត និងការ ស្រម៉ៃខ្ពស់ អមជាមួយ ឈុតឆាក បាញ់ប្រហារ គ្មានប្រណីដៃ។\n\nរឿង Divergent វគ្គក្រោយនេះ មានឈ្មោះថា Allegiant ដែលមានការ ចូលរួម សម្តែង ដោយ តារាល្បីៗ នៅសល់ពី វគ្គមុនៗ ដូចជា Shailene Woodley ហើយនេះ ជាវគ្គទី 3 ផងដែរ។" ImagePath:@"article3.jpg"];
    
    Article *art4 = [[Article alloc]initWithTitle:@"ក្រុមហ៊ុន ICE រៀប​ចំ​កម្មវិធី​ផ្តល់​ជូន​ពិសេស ដើម្បី​អប​អរ​ព្រះ​រាជ​ពិធី​បុណ្យ​អុំទូក អក​អំបុក បណ្តែត​ប្រទីប​ និង​សំពះ​ព្រះខែ !!!" Content:@"ដូចដែល ប្រិយមិត្តភាគច្រើន ធ្លាប់ស្គាល់អញ្ចឹង គឺថាក្រុមហ៊ុន ICE ឬ អាយ អេឡិកត្រូនិក គឺជាក្រុមហ៊ុនមួយ ដែលចែកចាយ កុំព្យូទ័រ Lenovo និងឧបករណ៍ អេឡិចត្រូនិក គ្រប់ប្រភេទ នៅក្នុងប្រទេសកម្ពុជាយើង។\n\n យ៉ាងណាមិញ ដើម្បីជាការអបអរ ក្នុងឱកាសបុណ្យអុំទូក ដែលជិតមកដល់ ក្នុងពេលឆាប់ៗ ខាងមុខនេះ ក្រុមហ៊ុន ICE បានរៀបចំ កម្មវិធីពិសេសមួយ ជូនដល់អតិថិជន របស់ខ្លួន ដែលកម្មវិធីនេះ នឹងចាប់ផ្តើម ចាប់ពីថ្ងៃទី 16 ខែវិច្ឆិកា នេះរហូតដល់ ថ្ងៃទី 28 ខែវិច្ឆិកា ឆ្នាំ 2015 ខាងមុខនេះ។\n\nគូសបញ្ជាក់ដែរថា នៅក្នុងកម្មវិធីនេះ សម្រាប់អតិថិជន ទាំងអស់ ដែលបានជាវ ម៉ាស៊ីនកុំព្យូទ័រ យួរដៃម៉ាក Lenovo ម៉ូឌែល G4070 (59438333) ក្នុងតម្លៃ $460, ម៉ូឌែល G4070 (59432395) ក្នុងតម្លៃ $655 និងម៉ូឌែល G4080 (80KY002PVN)(80KY0054VN) ក្នុងតម្លៃ $460 ពីក្រុមហ៊ុននោះ នឹងទទួលបាន ការបន្ថែមជូន កាដូពិសេស ចំនួនបីយ៉ាង ដូចជា ឧបាល័របំពងសម្លេង ម៉ូឌែល BT410 (តម្លៃ $60) ចំនួនមួយគ្រឿង, Mouse ម៉ាក N3903 (តម្លៃ $12) ចំនួនមួយ និងកាបូបដាក់ម៉ាស៊ីន កុំព្យូទ័រយូរដៃ Lenovo ម៉ូឌែល KR-3907 (តម្លៃ $35) ចំនួនមួយ។ ហើយដើម្បី ទទួលបាននូវកញ្ចប់ កាដូពិសេស ទាំងបីខាងលើនេះ គឺតម្រូវអោយ អតិថិជនត្រូវបន្ថែម ប្រាក់ចំនួន $35 ទៅលើតម្លៃ ម៉ាស៊ីនកុំព្យូទ័រយួរដៃ Lenovo និមួយៗ ដែលអតិថិជន បានជ្រើសរើស។\\ សម្រាប់ពត៌មានបន្ថែម សូមទំនាក់ទំនង មកកាន់ក្រុមហ៊ុន ICE ដែលមានលេខទូរស័ព្ទ 023 222 924 ឬ 077 888 187។ លោកអ្នកក៏អាចទំនាក់ទំនងផ្ទាល់ មកកាន់ក្រុមហ៊ុន ICE ទាំងបីសាខា បានផងដែរ ដែលមានទីតាំង ស្ថិតនៅ៖\n ទីតាំងសាខាព្រះសីហនុ៖ អគារ 293-295 មហាវិថីព្រះសីហនុ សង្កាត់វាលវង់ ខ័ណ្ឌ ៧ មករា ក្រុងភ្នំពេញ\nទីតាំងសាខាព្រះមុនីវង្ស៖ អគារ 246Eo+E1 មហាវិថីព្រះមុនីវង្ស សង្កាត់បឹងរាំង ខ័ណ្ឌដូនពេញ ក្រុងភ្នំពេញ\n\nទីតាំងសាខាទឹកថ្លា៖ អគារ 61-63 ផ្លូវ 1019 សង្កាត់ទឹកថ្លា ខ័ណ្ឌសែនសុខ ក្រុងភ្នំពេញ !!!" ImagePath:@"article4.jpg"];
    
    Article *art5 = [[Article alloc]initWithTitle:@"Cambo Pictures ជា​សមាជិក​ថ្មី​របស់ Cambo Report! ចង់​ដឹង​ថា អ្នក​ចំណូល​ថ្មី​នេះ នាំ​ជូន​នូវ​អ្វី​ពិសេស​ខ្លះ​? តាម​ដាន​ទាំង​អស់​គ្នា!​!!" Content:@"ខេមបូរីផត ជាគេហទំព័របច្ចេកវិទ្យា សម្រាប់ប្រជាជនកម្ពុជា បើកដំណើរការជាផ្លូវការនៅក្នុងឆ្នាំ 2013 ដែល​ក្នុងនោះប្រមូល ​ផ្តុំ​ទៅ​ដោយ​គន្លឹះ​ល្អៗ​ ជា​ច្រើន​ទាក់​ទង​ទៅ​នឹង​ បច្ចេកវិទ្យា​ថ្មីៗ ​នៅ​ជុំវិញ​ពិភពលោក​ ចំនេះ​ដឹង​ផ្នែក ​ពត៌មាន​វិទ្យា​ ទូរស័ព្ទ ថេប្លេត កុំព្យូទ័រ កាមេរ៉ា និង​ភាពយន្ត​ជា​ដើម។​ មិន​តែ​ប៉ុណ្ណោះ ក្រុម​ការងារ​ខេមបូរីផត​យើង​ខ្ញុំ​ ក៏​បាន​បង្ហាញ​នូវ ​វិធីសាស្ត្រ​ល្អៗ​ក្នុង​ការ​ប្រើប្រាស់​ ក៏​ដូច​ជា​តម្លើង​ Tweak, Theme, Jailbreak, Launcher, កម្មវិធី និង ហ្គេម ផង​ដែរ។\n\n ចំនេះដឹងល្អៗក្នុងការប្រើប្រាស់ ស្មាតហ្វូន ថេប្លេត កុំព្យូទ័រ ដែលក្រុមការងារ​យើង​ បាន​សម្រិត​សម្រាំង ​ឡើង​ក្នុង​គោល ​បំណង​ចែក​រំលែក​ អប់រំ​ ក៏​ដូច​ជា​លើក​ទឹក​ចិត្ត ​ដល់​ប្រជាជន​ខ្មែរ​ ឲ្យ​ចេះ​ដោះ​ស្រាយ​ បញ្ហា​ដែល​កើត​មាន​ឡើង​ ជាយថាហេតុ​ក្នុង​ ឧបករណ៍​របស់​គេ​ បាន​ដោយ​ខ្លួន​ឯង​ និង​មាន​ប្រសិទ្ធភាព។ ការ​ប្រើប្រាស់​ទៅ​លើ​ ឧបករណ៍​របស់​គេ​ ឲ្យ​អស់​ទៅ​តាម​ លទ្ធភាព​ដែល​មាន​ ការ​តុប​តែង​ក៍​ដូច​ជា ​វិធីសាស្រ្ត​ក្នុង​ការ ​ជួយ​សម្រួល​ ឲ្យ​ការ​ប្រើប្រាស់​ កាន់​តែ​រលូន និង​បញ្ហា​មួយ​ចំនួនទៀត ​ដែល​គួរ​ជៀសវាង​ សុទ្ធ​តែ​ជា​ផ្នែក​មួយ​ នៃ​អ្វី​ដែល​ក្រុម ​ការងារ​យើង​ បាន​ខិត​ខំ​សិក្សា​ស្រាវជ្រាវ​ និង​បង្ហាញ​ជូន​ ដល់​ប្រជាជន​ខ្មែរ​ទាំង​អស់។\n\n មិនតែប៉ុណ្ណោះ យើងក៏នៅមានការពិពណ៌នា ផលិតផលអេឡិចត្រូនិចថ្មីៗ​ ដែល​មាន​ដូច​ជា​ស្មាតហ្វូន​ ថេប្លេត កាមេរ៉ា… ជា​ភាសាខ្មែរ​ដំបូង​បង្អស់​ នៅ​ក្នុង​ប្រទេស​កម្ពុជា​ យើង​ផង​ដែរ​ ដែល​អាច​បង្ហាញ​ថា​ខ្មែរ​យើង​ក៏​អាច​ប្រើប្រាស់​ ភាសា​ជាតិ​យើង​រួម​បញ្ចូល​ជា​មួយ​ បច្ចេកវិទ្យា​ក្នុង​ការ​ពិពណ៌នា​ពី​ផលិតផល​អេឡិចត្រូនិច និង បច្ចេកវិទ្យាថ្មីៗ​បាន​ដូច​គេ​ដែរ។\n\nទាំងអស់នេះ គឺជាសមិទ្ធផលដែលក្រុម ការងារខេមបូរីផត បាន​សម្រេច​បាន​ និង​ចែក​រំលែក ​ដល់​ប្រជាជន​ខ្មែរ។ ហើយ​ក្នុង​ថ្ងៃ​នេះ​ដែរ​ ក្រុម​ការងារ​យើង​មាន​ សេចក្តី​សោមនស្ស​ រីករាយ​យ៉ាង​ខ្លាំង​ ក្នុង​ការណែនាំជូន​ប្រិយមិត្ត​ខេមបូរីផត​ទាំង​អស់​ នូវផ្នែកថ្មីមួយទៀតរបស់យើង នោះគឺ Cambo Pictures ។ វាគឺជា កំណែទម្រង់ មួយផ្សេង ទៀតរួមបញ្ចូលជា មួយបច្ចេកវិទ្យា ក្នុងការធ្វើ ឲ្យលេចចេញ នូវស្នាដៃថ្មី ដែលបង្កើតដោយកូនខ្មែរយើង។\n\nCambo Pictures ជាសមាជិកថ្មីរបស់ Cambo Report ដែលយើងក៏អាចហៅវា បានថាជាផលិតកម្ម មួយផងដែរ។ គម្រោងក្នុង ការបង្កើត Cambo Pictures នេះឡើង យើងចំណាយពេល ជិត 2 ឆ្នាំ ក្នុងការសិក្សាស្វែង យល់ពីវាឲ្យ បានច្បាស់ មុននឹង សម្រេច បង្កើតវាឡើងដោយ ក្រុមការងារ យើងបានព្យាយាម សម្រិតសម្រាំង នូវរាល់អ្វីដែលយើងបាន ធ្វើឲ្យមានគុណភាព ជាមុនសិន។ គោលដៅចំបងក្នុងការ បង្កើតចេញនូវ ផលិតកម្ម មួយនេះឡើងមានដូចជា៖\n\n ពង្រឹងនូវគុណភាពខ្សែភាពយន្តខ្មែរ\n\n បង្កើតនូវ បទចម្រៀង ក៏ដូចជាវីដេអូចម្រៀងថ្មី ដែលបង្កើតឡើងដោយកូនខ្មែរ (Original Song) និង​ (Official MV)\n\n ពង្រឹងនូវគុណភាពក្នុងការថត Pre-Wedding\n\nបង្កើតនូវវីដអូខ្លីក្នុងការ ផ្សព្វផ្សាយពាណិជ្ជកម្ម (TVC)" ImagePath:@""];
    
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjects:@[art1] forKeys:@[@"article"]];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:@[art2] forKeys:@[@"article"]];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjects:@[art3] forKeys:@[@"article"]];
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjects:@[art4] forKeys:@[@"article"]];
    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjects:@[art5] forKeys:@[@"article"]];
    
    articleArray = [[NSMutableArray alloc]initWithObjects:dic1, dic2, dic3, dic4, dic5, nil];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:75/255.0f green:157/255.0f blue:78/255.0f alpha:1.0f];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.customTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    
}


-(void)refreshData{
    
    Article *art1 = [[Article alloc]initWithTitle:@"Cydia Substrate ចេញ​កំណែ​ទម្រង់​ថ្មី​ហើយ ដូច្នេះ Tweak ចាស់ៗ​មួយ​ចំនួន​ធំ​អាច​ដំណើរ​ការ​លើ iOS 9" Content:@"លោក Saurik បាន​បញ្ចេញ Cydia Substrate ជំនាន់ថ្មី ហើយដើម្បីស្រប តាមតម្រូវការ អ្នកបង្កើត Tweak មួយចំនួន និងដើម្បី ទៅកែប្រព័ន្ធ ប្រតិបត្តិការ iOS 9 អោយវាអាច ដំណើរការ Tweak ចាស់ៗមួយចំនួនធំ ផងដែរ។\n\n មកទល់ពេលនេះ អ្នកអាច Update Cydia ទៅកាន់ ជំនាន់ 0.9.6110 បានហើយ​ ប្រសិនបើអ្នក មិនទាន់ Update ទេ សូមភ្ជាប់ ទៅកាន់ អ៊ីនធើណែត និង ចូលទៅ Cydia ធ្វើការ Refresh រួច Update វាជាបន្ទាន់។ រឿង Update Cydia Substrate មិនអាច អាក់ខាន បានឡើយ ព្រោះ Cydia Substrate វាជាផ្នែកមួយ ដ៏ធំ ជួយអោយ ដំណើរការ Tweak ក្រោយពេលដែល Jailbreak រួចរាល់ ប្រសិនបើ វាមានបញ្ហា វាអាច បណ្តាលអោយ ខូចប្រព័ន្ធ ប្រតិបត្តិការ របស់អ្នក ផងដែរ។\n\n យើងជឿជាក់ថា កំណែទម្រង់ Cydia Substrate ជំនាន់ថ្មីនេះ វានឹងជួយ សម្រួលការងារ ច្រើនដល់ប្រព័ន្ធ ប្រតិបត្តិការអ្នក រួមទាំង ផ្តល់ភាព ងាយស្រួលដល់ អ្នកបង្កើត Tweak ផងដែរ។ ប្រសិនបើអ្នក ចង់ព្យាយាម តម្លើង Tweak ចាស់ៗ អ្នកអាច សាកល្បងបាន តែគួរទុក ចិត្តថា Tweak នោះ វាមិន ចាស់ខ្លាំងពេក ប្រសិនបើវា ធ្លាប់ដំណើរ ការលើ iOS 8 អ្នកអាច ព្យាយាមបាន តែមានការ ទទួលខុស ត្រូវដោយខ្លួនឯង។" ImagePath:@"article1.jpg"];
    
    
    Article *art2 = [[Article alloc]initWithTitle:@"បង្កើត​ទីក្រុង ពោរ​ពេញ​ដោយ​ភាព​ស្រស់​បំព្រង​ជាមួយ​ហ្គេម​កសិដ្ឋាន​ចេញថ្មី Everytown!" Content:@"កាលពីប៉ុន្មាន សប្តាហ៍មុន ខេមបូ បាន​លើក​យក កសិដ្ឋាន​ថ្មីមួយ ដែល​មាន​ឈ្មោះ Farm Away ហើយ​វា​អាច​ដំណើរ​ការ បាន​តែ​សំរាប់ ប្រព័ន្ធ​ប្រតិបត្តិការ iOS តែប៉ុណ្ណោះ រីឯប្រព័ន្ធដទៃ ផ្សេងទៀត នៅ​ពុំ​ទាន់​អាច​ដំណើរការ បាននោះទេ។ \n\n ដោយឡែក មានហ្គេម កសិដ្ឋានមួយ ដែលទើបនឹង ចេញថ្មីដែរ មានឈ្មោះថា Everytown ប៉ុន្តែពិសេស​ជាង ដោយមានសាងសង់ ឧបករណ៍ផលិត អាហារ, ដាក់ចំណីអោយ សត្វចិញ្ចឹម, ដាំបន្លែ, រៀប​ចំ​ទីក្រុង​មួយ និងអោយមាន រចនាបថ សោភណ័ភាព ស្រស់ស្អាត និងដទៃទៀត ជាច្រើន។" ImagePath:@"article2.jpg"];
    
    
    Article *art3 = [[Article alloc]initWithTitle:@"រឿង Divergent ប្រភេទ​រឿង​បាញ់​ប្រហារ, អភិនីហា និង​ការ​ស្រម៉ៃ​ខ្ពស់ បាន​ចេញ​ឈុត​ខ្លី​វគ្គ​ថ្មី​ដំបូងហើយ!" Content:@"នេះជាឈុតខ្លីដំបូង ដែលជាវគ្គបន្ទាប់ របស់រឿង Divergent ដែលយើង បានដឹងថា ជារឿងបែប ស្មុគស្មាញ, បរិយាយពី ភាពប្រឌិត និងការ ស្រម៉ៃខ្ពស់ អមជាមួយ ឈុតឆាក បាញ់ប្រហារ គ្មានប្រណីដៃ។\n\nរឿង Divergent វគ្គក្រោយនេះ មានឈ្មោះថា Allegiant ដែលមានការ ចូលរួម សម្តែង ដោយ តារាល្បីៗ នៅសល់ពី វគ្គមុនៗ ដូចជា Shailene Woodley ហើយនេះ ជាវគ្គទី 3 ផងដែរ។" ImagePath:@"article3.jpg"];
    
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjects:@[art1] forKeys:@[@"article"]];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:@[art2] forKeys:@[@"article"]];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjects:@[art3] forKeys:@[@"article"]];
    
    
    [articleArray addObject:dic1];
    [articleArray addObject:dic2];
    [articleArray addObject:dic3];
    

    [self.customTableView reloadData];
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[_customTableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        //for example [activityIndicator stopAnimating];
        [self.refreshControl endRefreshing];
        
        if (self.refreshControl) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
            
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                        forKey:NSForegroundColorAttributeName];
            NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
            self.refreshControl.attributedTitle = attributedTitle;
           
            [self.refreshControl endRefreshing];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [articleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Article *article = [[articleArray objectAtIndex:indexPath.row] objectForKey:@"article"];
    
    
    if([[article image] isEqual: @""]){
        
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithoutImage" forIndexPath:indexPath];
        cell.labelTitleWithoutImage.text = [article title];
        cell.labelContentWithoutImage.text = [article content];
        [cell.labelContentWithoutImage sizeToFit];
        return cell;
    }
    else{
        CustomTableViewCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"cellWithImage" forIndexPath:indexPath];
        
        cell.labelTitle.text = [article title];
        cell.imageViewImage.image = [UIImage imageNamed:[article image]];
        cell.labelContent.text = [article content];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[[[articleArray objectAtIndex:indexPath.row] objectForKey:@"article"] image] isEqual:@""]){
        [self performSegueWithIdentifier:@"segueArticleDetailsNoImage" sender:[[articleArray objectAtIndex:indexPath.row] objectForKey:@"article"]];
        
    }else{
        [self performSegueWithIdentifier:@"segueArticleDetails" sender:[[articleArray objectAtIndex:indexPath.row] objectForKey:@"article"]];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"segueArticleDetails"]) {
        ArticleDetailsViewController  *articleDetails = [segue destinationViewController];
        articleDetails.article = sender;
    }else  if ([segue.identifier isEqualToString:@"segueArticleDetailsNoImage"]) {
        ArticleDetailsNoImageViewController  *articleDetailsNoImage = [segue destinationViewController];
        articleDetailsNoImage.article = sender;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

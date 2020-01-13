#import "AVAModalWebViewController.h"

@interface AVAModalWebViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *qtyText;
@property (nonatomic, strong) UILabel *estAmountText;
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic, strong) NSNumber *price;

@end

@implementation AVAModalWebViewController

- (void)viewDidLoad {

	[super viewDidLoad];

	UILabel *tradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,50,200,30)];
	tradeLabel.text = @"Trade";
	[self.navigationController.view addSubview:tradeLabel];

	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(_handleClose:)];
	self.navigationItem.rightBarButtonItem = closeButton;
	self.navigationItem.title = @"Buy"
	;	self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:97.0/255.0 green:169.0/255.0 blue:255.0/255.0 alpha:1.0]};
}


-(void)viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];

	self.view.backgroundColor = [UIColor whiteColor];
}

-(void) setupViews {

	// 1st Row
	// Quantity Label
	UILabel *qtyLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, 200, 20)];
	qtyLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	qtyLabel.text = @"Quantity";
	[self.view addSubview:qtyLabel];

	// Quantity Value
	UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
	numberToolbar.barStyle = UIBarStyleBlackTranslucent;
	numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
													[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
	[numberToolbar sizeToFit];

	self.qtyText = [[UITextField alloc] initWithFrame:CGRectMake(30, 190, 200, 20)];
	self.qtyText.keyboardType = UIKeyboardTypeNumberPad;
	self.qtyText.inputAccessoryView = numberToolbar;
	self.qtyText.text = @"1";
	[self.view addSubview:self.qtyText];

	UIView *firstLine = [[UIView alloc] initWithFrame:CGRectMake(30, 220, 140, 1)];
	firstLine.backgroundColor = [UIColor grayColor];
	[self.view addSubview:firstLine];

	//Estimated Amount Label
	UILabel *estAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 140, 200, 20)];
	estAmountLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	estAmountLabel.text = @"Est. CHF Amount";
	[self.view addSubview:estAmountLabel];

	//Estimated Amount Value
	self.estAmountText = [[UILabel alloc]initWithFrame:CGRectMake(200, 190, 200, 20)];
	NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
	f.numberStyle = NSNumberFormatterDecimalStyle;
	self.estAmountText.text = [self calculateEstimatedCHFAmountWithQuantity:[f numberFromString:self.qtyText.text] andPrice:self.price];
	[self.view addSubview:self.estAmountText];

	UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(200, 220, 140, 1)];
	secondLine.backgroundColor = [UIColor grayColor];
	[self.view addSubview:secondLine];

	//2nd row
	UILabel *orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 300, 200, 20)];
	orderLabel.text = @"Order Type";
	[self.view addSubview:orderLabel];

	UILabel *orderText = [[UILabel alloc]initWithFrame:CGRectMake(200, 300, 200, 20)];
	orderText.text = @"Market";
	[self.view addSubview:orderText];

	UIView *thirdLine = [[UIView alloc] initWithFrame:CGRectMake(30, 330, 310, 1)];
	thirdLine.backgroundColor = [UIColor grayColor];
	[self.view addSubview:thirdLine];

	//3rd row
	UILabel *validityLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 450, 200, 20)];
	validityLabel.text = @"Validity";
	[self.view addSubview:validityLabel];

	UIView *validityView = [[UIView alloc] initWithFrame:CGRectMake(200, 450, 200, 80)];

	UILabel *validityText = [[UILabel alloc]initWithFrame:CGRectMake(0, -20, 200, 20)];
	validityText.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
	validityText.text = @"Good For Day";

	UILabel *validityText2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
	validityText2.text = @"22.2.2020";

	[validityView addSubview:validityText];
	[validityView addSubview:validityText2];
	[self.view addSubview:validityView];

	UIView *fourthLine = [[UIView alloc] initWithFrame:CGRectMake(30, 480, 310, 1)];
	fourthLine.backgroundColor = [UIColor grayColor];
	[self.view addSubview:fourthLine];

	self.previewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[self.previewButton addTarget:self action:@selector(_handleClosePreview:) forControlEvents:UIControlEventTouchUpInside];
	self.previewButton.frame = CGRectMake(30, 600, 320, 40);
	self.previewButton.backgroundColor =  [UIColor colorWithRed:74.0/255.0 green:149.0/255.0 blue:251.0/255.0 alpha:1.0];
	[self.previewButton setTitle:@"Preview" forState:UIControlStateNormal];
	self.previewButton.layer.cornerRadius = 10;
	self.previewButton.clipsToBounds = YES;
	[self.previewButton setTitle:self.previewButton.titleLabel.text.uppercaseString forState:UIControlStateNormal];
	[self.previewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.view addSubview:self.previewButton];
}

- (void)viewDidDisappear:(BOOL)animated {

	[super viewDidDisappear:animated];
}

- (void)open:(nonnull NSNumber*)aPrice {

	self.price = aPrice;
	[self setupViews];
}

- (void)_handleClose:(id)sender {

	[self.delegate avaModalWebViewControllerDidClose];
}

- (void)_handleClosePreview:(id)sender {

	NSString *updatedData = [NSString stringWithFormat:@"%@,%@",self.qtyText.text, self.estAmountText.text];
	[self.delegate avaModalWebViewControllerDidClosePreview:updatedData];
}

-(void)cancelNumberPad{

	[self.qtyText resignFirstResponder];
}

-(void)doneWithNumberPad{

	int newQty = [self.qtyText.text intValue];

	[self.qtyText resignFirstResponder];

	self.estAmountText.text = [self calculateEstimatedCHFAmountWithQuantity:[NSNumber numberWithInt:newQty] andPrice:self.price];
}

-(NSString*)calculateEstimatedCHFAmountWithQuantity:(NSNumber *)qty andPrice:(NSNumber *)price {

	return [[NSNumber numberWithInt:[qty intValue] * [price intValue]] stringValue];
}

@end


#import "beacon.h"

@implementation BLEBeaconAdvertisement

- (id)initWithProximityUUID:(NSUUID *)proximityUUID major:(uint16_t)major minor:(uint16_t)minor measuredPower:(int8_t)power {
    self = [super init];

    if (self) {
        self.proximityUUID = proximityUUID;
        self.major = major;
        self.minor = minor;
        self.measuredPower = power;
    }

    return self;
}


- (NSDictionary *)beaconData {
    NSString *beaconKey = @"kCBAdvDataAppleBeaconKey";

    unsigned char advertisementBytes[21] = {0};

    [self.proximityUUID getUUIDBytes:(unsigned char *)&advertisementBytes];

    advertisementBytes[16] = (unsigned char)((self.major >> 8) & 255);
    advertisementBytes[17] = (unsigned char)(self.major & 255);

    advertisementBytes[18] = (unsigned char)((self.minor >> 8) & 255);
    advertisementBytes[19] = (unsigned char)(self.minor & 255);

    advertisementBytes[20] = (unsigned char)(self.measuredPower);

    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementBytes length:21];

    return [NSDictionary dictionaryWithObject:advertisement forKey:beaconKey];
}

@end

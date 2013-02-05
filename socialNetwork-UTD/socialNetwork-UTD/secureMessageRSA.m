//
//  secureMessageRSA.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 04/11/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "secureMessageRSA.h"

@implementation secureMessageRSA

/*key-identifiers*/
static const UInt8 privateKeyIdentifier[] = "privKey\0";
static const UInt8 publicKeyIdentifier[] = "pubKey\0";

/*Crypto Buffers*/
size_t cipherBufferSize;
uint8_t *cipherBuffer;
size_t plainBufferSize;
uint8_t *plainBuffer;

/*Generate public-private key pairs*/
+(void)generateKeyPairs
{
    OSStatus status = noErr;
    
    NSMutableDictionary *privateKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *publicKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *keyPairAttr = [[NSMutableDictionary alloc] init];
    
    
    NSData * publicTag = [NSData dataWithBytes:publicKeyIdentifier
                                        length:strlen((const char *)publicKeyIdentifier)];
    NSData * privateTag = [NSData dataWithBytes:privateKeyIdentifier
                                         length:strlen((const char *)privateKeyIdentifier)];
    
    
    SecKeyRef publicKey = NULL;
    SecKeyRef privateKey = NULL;
    
    [keyPairAttr setObject:(id)kSecAttrKeyTypeRSA
                    forKey:(id)kSecAttrKeyType];
    [keyPairAttr setObject:[NSNumber numberWithInt:1024]
                    forKey:(id)kSecAttrKeySizeInBits];
    
    [publicKeyAttr setObject:[NSNumber numberWithBool:YES]
                      forKey:(id)kSecAttrIsPermanent];
    [publicKeyAttr setObject:publicTag
                      forKey:(id)kSecAttrApplicationTag];
    
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES]
                       forKey:(id)kSecAttrIsPermanent];
    [privateKeyAttr setObject:privateTag
                       forKey:kSecAttrApplicationTag];
    
    [keyPairAttr setObject:privateKeyAttr
                    forKey:(id)kSecPrivateKeyAttrs];
    [keyPairAttr setObject:publicKeyAttr
                    forKey:(id)kSecPublicKeyAttrs];
    
    
    status=SecKeyGeneratePair((CFDictionaryRef)keyPairAttr, &publicKey, &privateKey);
    NSLog(@"%ld",status);
    NSLog(@"pub: %@",(NSString *)publicKey);
    NSLog(@"priv: %@",(NSString *)privateKey);
    
    
    if(privateKeyAttr) [privateKeyAttr release];
    if(publicKeyAttr) [publicKeyAttr release];
    if(keyPairAttr) [keyPairAttr release];
    if(publicKey) CFRelease(publicKey);
    if(privateKey) CFRelease(privateKey);
}

/*Encrypt message using public key*/
+(void)encryptMessage:(NSString *)message
{
    OSStatus sanityCheck = noErr;
    int msgLength = [message length];
    uint8_t data[msgLength];
    for(int i=0;i<msgLength;i++)
    {
        data[i]=[message characterAtIndex:i] ;
    }
    SecKeyRef pubKey = NULL;      /*holds the pub key*/
    NSData *pubTag=[NSData dataWithBytes:publicKeyIdentifier length:strlen((const char *)publicKeyIdentifier)];
    
    NSMutableDictionary *pubKeyDict = [[NSMutableDictionary alloc]init];
    [pubKeyDict setObject:(id)kSecClassKey forKey:(id)kSecClass];
    [pubKeyDict setObject:pubTag forKey:(id)kSecAttrApplicationTag];
    [pubKeyDict setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    [pubKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
    
    /*copy the key from keychain to pubkey*/
    sanityCheck =
    SecItemCopyMatching((CFDictionaryRef)pubKeyDict,(CFTypeRef *)&pubKey);
    
    /*Allocate crypto buffer*/
    cipherBufferSize=SecKeyGetBlockSize(pubKey);
    cipherBuffer=malloc(cipherBufferSize);
    
    /*Start Encrypting*/
    sanityCheck=
    SecKeyEncrypt(pubKey, kSecPaddingPKCS1, data, sizeof(data), cipherBuffer, &cipherBufferSize);
    NSLog(@"Encrypted text: %s",cipherBuffer);
    
    if(pubKey) CFRelease(pubKey);
    if(pubKeyDict) CFRelease(pubKeyDict);
    if(plainBuffer) free(plainBuffer);
    //free(cipherBuffer);          /*transmit over network first & then free*/
}

/*Decrypt message using private key*/
+(void)decryptMessage
{
    OSStatus sanityCheck=noErr;
    
    SecKeyRef privKey=NULL;
    NSData *privTag=[[NSData alloc]initWithBytes:privateKeyIdentifier length:strlen((const char *)privateKeyIdentifier)];
    
    NSMutableDictionary *privKeyDict=[[NSMutableDictionary alloc]init];
    [privKeyDict setObject:(id)kSecClassKey forKey:(id)kSecClass];
    [privKeyDict setObject:privTag forKey:(id)kSecAttrApplicationTag];
    [privKeyDict setObject:(id)kSecAttrKeyTypeRSA forKey:(id)kSecAttrKeyType];
    [privKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(id)kSecReturnRef];
    
    sanityCheck=
    SecItemCopyMatching((CFDictionaryRef)privKeyDict, (CFTypeRef *)&privKey);
    
    /*Allocate crypto buffer*/
    plainBufferSize=SecKeyGetBlockSize(privKey);
    plainBuffer=malloc(plainBufferSize);
    /*start decrypting*/
    sanityCheck=
    SecKeyDecrypt(privKey, kSecPaddingPKCS1, cipherBuffer, cipherBufferSize, plainBuffer, &plainBufferSize);
    
    NSLog(@"Decrypted text: %s",plainBuffer);
    free(cipherBuffer);
}
@end

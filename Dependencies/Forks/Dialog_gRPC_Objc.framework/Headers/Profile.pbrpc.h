// Code generated by gRPC proto compiler.  DO NOT EDIT!
// source: profile.proto

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "Profile.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class RequestChangeUserStatus;
@class RequestCheckNickName;
@class RequestEditAbout;
@class RequestEditAvatar;
@class RequestEditCustomProfile;
@class RequestEditMyPreferredLanguages;
@class RequestEditMyTimeZone;
@class RequestEditName;
@class RequestEditNickName;
@class RequestEditSex;
@class RequestRemoveAvatar;
@class ResponseBool;
@class ResponseEditAvatar;
@class ResponseSeq;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  #import "Wrappers.pbobjc.h"
  #import "Annotations.pbobjc.h"
  #import "Definitions.pbobjc.h"
  #import "Miscellaneous.pbobjc.h"
  #import "MediaAndFiles.pbobjc.h"
  #import "Users.pbobjc.h"
  #import "Scalapb.pbobjc.h"
#endif

@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;
@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol Profile2 <NSObject>

#pragma mark EditName(RequestEditName) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editNameWithMessage:(RequestEditName *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditNickName(RequestEditNickName) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editNickNameWithMessage:(RequestEditNickName *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark CheckNickName(RequestCheckNickName) returns (ResponseBool)

- (GRPCUnaryProtoCall *)checkNickNameWithMessage:(RequestCheckNickName *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditAbout(RequestEditAbout) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editAboutWithMessage:(RequestEditAbout *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditAvatar(RequestEditAvatar) returns (ResponseEditAvatar)

- (GRPCUnaryProtoCall *)editAvatarWithMessage:(RequestEditAvatar *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RemoveAvatar(RequestRemoveAvatar) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)removeAvatarWithMessage:(RequestRemoveAvatar *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditMyTimeZone(RequestEditMyTimeZone) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editMyTimeZoneWithMessage:(RequestEditMyTimeZone *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditMyPreferredLanguages(RequestEditMyPreferredLanguages) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editMyPreferredLanguagesWithMessage:(RequestEditMyPreferredLanguages *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditSex(RequestEditSex) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editSexWithMessage:(RequestEditSex *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EditCustomProfile(RequestEditCustomProfile) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)editCustomProfileWithMessage:(RequestEditCustomProfile *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ChangeUserStatus(RequestChangeUserStatus) returns (ResponseSeq)

- (GRPCUnaryProtoCall *)changeUserStatusWithMessage:(RequestChangeUserStatus *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol Profile <NSObject>

#pragma mark EditName(RequestEditName) returns (ResponseSeq)

- (void)editNameWithRequest:(RequestEditName *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditNameWithRequest:(RequestEditName *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditNickName(RequestEditNickName) returns (ResponseSeq)

- (void)editNickNameWithRequest:(RequestEditNickName *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditNickNameWithRequest:(RequestEditNickName *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark CheckNickName(RequestCheckNickName) returns (ResponseBool)

- (void)checkNickNameWithRequest:(RequestCheckNickName *)request handler:(void(^)(ResponseBool *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCheckNickNameWithRequest:(RequestCheckNickName *)request handler:(void(^)(ResponseBool *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditAbout(RequestEditAbout) returns (ResponseSeq)

- (void)editAboutWithRequest:(RequestEditAbout *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditAboutWithRequest:(RequestEditAbout *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditAvatar(RequestEditAvatar) returns (ResponseEditAvatar)

- (void)editAvatarWithRequest:(RequestEditAvatar *)request handler:(void(^)(ResponseEditAvatar *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditAvatarWithRequest:(RequestEditAvatar *)request handler:(void(^)(ResponseEditAvatar *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RemoveAvatar(RequestRemoveAvatar) returns (ResponseSeq)

- (void)removeAvatarWithRequest:(RequestRemoveAvatar *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRemoveAvatarWithRequest:(RequestRemoveAvatar *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditMyTimeZone(RequestEditMyTimeZone) returns (ResponseSeq)

- (void)editMyTimeZoneWithRequest:(RequestEditMyTimeZone *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditMyTimeZoneWithRequest:(RequestEditMyTimeZone *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditMyPreferredLanguages(RequestEditMyPreferredLanguages) returns (ResponseSeq)

- (void)editMyPreferredLanguagesWithRequest:(RequestEditMyPreferredLanguages *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditMyPreferredLanguagesWithRequest:(RequestEditMyPreferredLanguages *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditSex(RequestEditSex) returns (ResponseSeq)

- (void)editSexWithRequest:(RequestEditSex *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditSexWithRequest:(RequestEditSex *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EditCustomProfile(RequestEditCustomProfile) returns (ResponseSeq)

- (void)editCustomProfileWithRequest:(RequestEditCustomProfile *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToEditCustomProfileWithRequest:(RequestEditCustomProfile *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ChangeUserStatus(RequestChangeUserStatus) returns (ResponseSeq)

- (void)changeUserStatusWithRequest:(RequestChangeUserStatus *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToChangeUserStatusWithRequest:(RequestChangeUserStatus *)request handler:(void(^)(ResponseSeq *_Nullable response, NSError *_Nullable error))handler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Profile : GRPCProtoService<Profile2, Profile>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

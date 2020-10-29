// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: obsolete.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30004
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30004 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

@class GPBBytesValue;
@class GPBEmpty;
@class GPBInt32Value;
@class GPBInt64Value;
@class GPBStringValue;
@class ObsoleteOutPeer;
@class ObsoletePeer;
@class ObsoletePeersList;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDisposed;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateTyping;
@class ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen;
@class ObsoleteWeakUpdateCommand_ObsoleteMyOnline;
@class ObsoleteWeakUpdateCommand_ObsoleteMyTyping;
@class UpdateSeqUpdate;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum ObsoleteTypingType

typedef GPB_ENUM(ObsoleteTypingType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  ObsoleteTypingType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  ObsoleteTypingType_ObsoleteTypingtypeUnknown = 0,
  ObsoleteTypingType_ObsoleteTypingtypeText = 1,
};

GPBEnumDescriptor *ObsoleteTypingType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL ObsoleteTypingType_IsValidValue(int32_t value);

#pragma mark - Enum ObsoletePeer_ObsoletePeerType

typedef GPB_ENUM(ObsoletePeer_ObsoletePeerType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  ObsoletePeer_ObsoletePeerType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  ObsoletePeer_ObsoletePeerType_ObsoletePeertypeUnknown = 0,
  ObsoletePeer_ObsoletePeerType_ObsoletePeertypePrivate = 1,
  ObsoletePeer_ObsoletePeerType_ObsoletePeertypeGroup = 2,

  /** PEERTYPE_ENCRYPTED_PRIVATE = 3; */
  ObsoletePeer_ObsoletePeerType_ObsoletePeertypeSip = 4,
};

GPBEnumDescriptor *ObsoletePeer_ObsoletePeerType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL ObsoletePeer_ObsoletePeerType_IsValidValue(int32_t value);

#pragma mark - Enum ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_ObsoleteDisposalReasonUnknown = 0,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_ObsoleteDisposalReasonRejected = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_ObsoleteDisposalReasonBusy = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_ObsoleteDisposalReasonEnded = 3,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_ObsoleteDisposalReasonAnswerTimeout = 4,
};

GPBEnumDescriptor *ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason_IsValidValue(int32_t value);

#pragma mark - ObsoleteRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
GPB_FINAL @interface ObsoleteRoot : GPBRootObject
@end

#pragma mark - ObsoletePeer

typedef GPB_ENUM(ObsoletePeer_FieldNumber) {
  ObsoletePeer_FieldNumber_Type = 1,
  ObsoletePeer_FieldNumber_Id_p = 2,
  ObsoletePeer_FieldNumber_StrId = 3,
  ObsoletePeer_FieldNumber_AccessHash = 4,
};

GPB_FINAL @interface ObsoletePeer : GPBMessage

@property(nonatomic, readwrite) ObsoletePeer_ObsoletePeerType type;

@property(nonatomic, readwrite) int32_t id_p;

@property(nonatomic, readwrite, strong, null_resettable) GPBStringValue *strId;
/** Test to see if @c strId has been set. */
@property(nonatomic, readwrite) BOOL hasStrId;

@property(nonatomic, readwrite) int64_t accessHash;

@end

/**
 * Fetches the raw value of a @c ObsoletePeer's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t ObsoletePeer_Type_RawValue(ObsoletePeer *message);
/**
 * Sets the raw value of an @c ObsoletePeer's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetObsoletePeer_Type_RawValue(ObsoletePeer *message, int32_t value);

#pragma mark - ObsoleteOutPeer

typedef GPB_ENUM(ObsoleteOutPeer_FieldNumber) {
  ObsoleteOutPeer_FieldNumber_Peer = 1,
  ObsoleteOutPeer_FieldNumber_AccessHash = 2,
};

GPB_FINAL @interface ObsoleteOutPeer : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeer *peer;
/** Test to see if @c peer has been set. */
@property(nonatomic, readwrite) BOOL hasPeer;

@property(nonatomic, readwrite) int64_t accessHash;

@end

#pragma mark - ObsoletePeersList

typedef GPB_ENUM(ObsoletePeersList_FieldNumber) {
  ObsoletePeersList_FieldNumber_PeersArray = 1,
};

GPB_FINAL @interface ObsoletePeersList : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ObsoletePeer*> *peersArray;
/** The number of items in @c peersArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger peersArray_Count;

@end

#pragma mark - ObsoleteGetDifferenceCommand

typedef GPB_ENUM(ObsoleteGetDifferenceCommand_FieldNumber) {
  ObsoleteGetDifferenceCommand_FieldNumber_Seq = 1,
  ObsoleteGetDifferenceCommand_FieldNumber_State = 2,
  ObsoleteGetDifferenceCommand_FieldNumber_ConfigHash = 3,
};

GPB_FINAL @interface ObsoleteGetDifferenceCommand : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *seq;
/** Test to see if @c seq has been set. */
@property(nonatomic, readwrite) BOOL hasSeq;

@property(nonatomic, readwrite, copy, null_resettable) NSData *state;

@property(nonatomic, readwrite) int64_t configHash;

@end

#pragma mark - ObsoleteSeqUpdateBox

typedef GPB_ENUM(ObsoleteSeqUpdateBox_FieldNumber) {
  ObsoleteSeqUpdateBox_FieldNumber_Seq = 1,
  ObsoleteSeqUpdateBox_FieldNumber_State = 2,
  ObsoleteSeqUpdateBox_FieldNumber_ObsoleteUpdate = 3,
};

typedef GPB_ENUM(ObsoleteSeqUpdateBox_Updatebox_OneOfCase) {
  ObsoleteSeqUpdateBox_Updatebox_OneOfCase_GPBUnsetOneOfCase = 0,
  ObsoleteSeqUpdateBox_Updatebox_OneOfCase_ObsoleteUpdate = 3,
};

GPB_FINAL @interface ObsoleteSeqUpdateBox : GPBMessage

@property(nonatomic, readwrite) int32_t seq;

@property(nonatomic, readwrite, copy, null_resettable) NSData *state;

@property(nonatomic, readonly) ObsoleteSeqUpdateBox_Updatebox_OneOfCase updateboxOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) GPBBytesValue *obsoleteUpdate;

@end

/**
 * Clears whatever value was set for the oneof 'updatebox'.
 **/
void ObsoleteSeqUpdateBox_ClearUpdateboxOneOfCase(ObsoleteSeqUpdateBox *message);

#pragma mark - ObsoleteWeakUpdateBox

typedef GPB_ENUM(ObsoleteWeakUpdateBox_FieldNumber) {
  ObsoleteWeakUpdateBox_FieldNumber_Date = 1,
  ObsoleteWeakUpdateBox_FieldNumber_Typing = 2,
  ObsoleteWeakUpdateBox_FieldNumber_UserLastSeen = 3,
  ObsoleteWeakUpdateBox_FieldNumber_GroupOnline = 4,
  ObsoleteWeakUpdateBox_FieldNumber_BusMessage = 5,
  ObsoleteWeakUpdateBox_FieldNumber_BusDeviceConnected = 6,
  ObsoleteWeakUpdateBox_FieldNumber_BusDeviceDisconnected = 7,
  ObsoleteWeakUpdateBox_FieldNumber_BusDisposed = 8,
  ObsoleteWeakUpdateBox_FieldNumber_ForceReload = 9,
  ObsoleteWeakUpdateBox_FieldNumber_IncomingCall = 10,
  ObsoleteWeakUpdateBox_FieldNumber_CallHandled = 11,
  ObsoleteWeakUpdateBox_FieldNumber_CallDisposed = 12,
  ObsoleteWeakUpdateBox_FieldNumber_UpdateAny = 13,
};

typedef GPB_ENUM(ObsoleteWeakUpdateBox_Updatebox_OneOfCase) {
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_GPBUnsetOneOfCase = 0,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_Typing = 2,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_UserLastSeen = 3,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_GroupOnline = 4,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_BusMessage = 5,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_BusDeviceConnected = 6,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_BusDeviceDisconnected = 7,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_BusDisposed = 8,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_ForceReload = 9,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_IncomingCall = 10,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_CallHandled = 11,
  ObsoleteWeakUpdateBox_Updatebox_OneOfCase_CallDisposed = 12,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox : GPBMessage

@property(nonatomic, readwrite) int64_t date;

@property(nonatomic, readonly) ObsoleteWeakUpdateBox_Updatebox_OneOfCase updateboxOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateTyping *typing;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen *userLastSeen;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline *groupOnline;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage *busMessage;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected *busDeviceConnected;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected *busDeviceDisconnected;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDisposed *busDisposed;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState *forceReload;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall *incomingCall;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled *callHandled;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed *callDisposed;

@property(nonatomic, readwrite, strong, null_resettable) UpdateSeqUpdate *updateAny;
/** Test to see if @c updateAny has been set. */
@property(nonatomic, readwrite) BOOL hasUpdateAny;

@end

/**
 * Clears whatever value was set for the oneof 'updatebox'.
 **/
void ObsoleteWeakUpdateBox_ClearUpdateboxOneOfCase(ObsoleteWeakUpdateBox *message);

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateTyping

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateTyping_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateTyping_FieldNumber_Peer = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateTyping_FieldNumber_UserId = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateTyping_FieldNumber_Type = 3,
  ObsoleteWeakUpdateBox_ObsoleteUpdateTyping_FieldNumber_IsTyping = 4,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateTyping : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeer *peer;
/** Test to see if @c peer has been set. */
@property(nonatomic, readwrite) BOOL hasPeer;

@property(nonatomic, readwrite) int32_t userId;

@property(nonatomic, readwrite) ObsoleteTypingType type;

@property(nonatomic, readwrite) BOOL isTyping;

@end

/**
 * Fetches the raw value of a @c ObsoleteWeakUpdateBox_ObsoleteUpdateTyping's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t ObsoleteWeakUpdateBox_ObsoleteUpdateTyping_Type_RawValue(ObsoleteWeakUpdateBox_ObsoleteUpdateTyping *message);
/**
 * Sets the raw value of an @c ObsoleteWeakUpdateBox_ObsoleteUpdateTyping's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetObsoleteWeakUpdateBox_ObsoleteUpdateTyping_Type_RawValue(ObsoleteWeakUpdateBox_ObsoleteUpdateTyping *message, int32_t value);

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen_FieldNumber_UserId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen_FieldNumber_EpochMillis = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen_FieldNumber_DeviceType = 3,
  ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen_FieldNumber_DeviceCategory = 4,
  ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen_FieldNumber_IsOnline = 5,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateUserLastSeen : GPBMessage

@property(nonatomic, readwrite) int32_t userId;

@property(nonatomic, readwrite) int64_t epochMillis;

@property(nonatomic, readwrite) int32_t deviceType;

@property(nonatomic, readwrite, copy, null_resettable) NSString *deviceCategory;

@property(nonatomic, readwrite) BOOL isOnline;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline_FieldNumber_GroupId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline_FieldNumber_Count = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline_FieldNumber_Clock = 3,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateGroupOnline : GPBMessage

@property(nonatomic, readwrite) int32_t groupId;

@property(nonatomic, readwrite) int32_t count;

@property(nonatomic, readwrite) int64_t clock;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage_FieldNumber_BusId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage_FieldNumber_SenderId = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage_FieldNumber_SenderDeviceId = 3,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage_FieldNumber_Message = 4,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusMessage : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *busId;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *senderId;
/** Test to see if @c senderId has been set. */
@property(nonatomic, readwrite) BOOL hasSenderId;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt64Value *senderDeviceId;
/** Test to see if @c senderDeviceId has been set. */
@property(nonatomic, readwrite) BOOL hasSenderDeviceId;

@property(nonatomic, readwrite, copy, null_resettable) NSData *message;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected_FieldNumber_BusId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected_FieldNumber_UserId = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected_FieldNumber_DeviceId = 3,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceConnected : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *busId;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *userId;
/** Test to see if @c userId has been set. */
@property(nonatomic, readwrite) BOOL hasUserId;

@property(nonatomic, readwrite) int64_t deviceId;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected_FieldNumber_BusId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected_FieldNumber_UserId = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected_FieldNumber_DeviceId = 3,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDeviceDisconnected : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *busId;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *userId;
/** Test to see if @c userId has been set. */
@property(nonatomic, readwrite) BOOL hasUserId;

@property(nonatomic, readwrite) int64_t deviceId;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDisposed

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDisposed_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDisposed_FieldNumber_BusId = 1,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateEventBusDisposed : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *busId;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber_CallId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber_BusId = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber_Peer = 3,
  ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber_DisplayName = 4,
  ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber_AttemptIndex = 5,
  ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall_FieldNumber_OutPeer = 6,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateIncomingCall : GPBMessage

@property(nonatomic, readwrite) int64_t callId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *busId;

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeer *peer;
/** Test to see if @c peer has been set. */
@property(nonatomic, readwrite) BOOL hasPeer;

@property(nonatomic, readwrite, strong, null_resettable) GPBStringValue *displayName;
/** Test to see if @c displayName has been set. */
@property(nonatomic, readwrite) BOOL hasDisplayName;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *attemptIndex;
/** Test to see if @c attemptIndex has been set. */
@property(nonatomic, readwrite) BOOL hasAttemptIndex;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteOutPeer *outPeer;
/** Test to see if @c outPeer has been set. */
@property(nonatomic, readwrite) BOOL hasOutPeer;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled_FieldNumber_CallId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled_FieldNumber_AttemptIndex = 2,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateCallHandled : GPBMessage

@property(nonatomic, readwrite) int64_t callId;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *attemptIndex;
/** Test to see if @c attemptIndex has been set. */
@property(nonatomic, readwrite) BOOL hasAttemptIndex;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_FieldNumber_CallId = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_FieldNumber_AttemptIndex = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_FieldNumber_Reason = 3,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed : GPBMessage

@property(nonatomic, readwrite) int64_t callId;

@property(nonatomic, readwrite, strong, null_resettable) GPBInt32Value *attemptIndex;
/** Test to see if @c attemptIndex has been set. */
@property(nonatomic, readwrite) BOOL hasAttemptIndex;

@property(nonatomic, readwrite) ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_ObsoleteDisposalReason reason;

@end

/**
 * Fetches the raw value of a @c ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed's @c reason property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_Reason_RawValue(ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed *message);
/**
 * Sets the raw value of an @c ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed's @c reason property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed_Reason_RawValue(ObsoleteWeakUpdateBox_ObsoleteUpdateCallDisposed *message, int32_t value);

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_FieldNumber_FieldsArray = 1,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField*> *fieldsArray;
/** The number of items in @c fieldsArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger fieldsArray_Count;

@end

#pragma mark - ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_FieldNumber) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_FieldNumber_ReloadDialogs = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_FieldNumber_ReloadContacts = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_FieldNumber_ReloadHistory = 3,
};

typedef GPB_ENUM(ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_Field_OneOfCase) {
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_Field_OneOfCase_GPBUnsetOneOfCase = 0,
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_Field_OneOfCase_ReloadDialogs = 1,
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_Field_OneOfCase_ReloadContacts = 2,
  ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_Field_OneOfCase_ReloadHistory = 3,
};

GPB_FINAL @interface ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField : GPBMessage

@property(nonatomic, readonly) ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_Field_OneOfCase fieldOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) GPBEmpty *reloadDialogs;

@property(nonatomic, readwrite, strong, null_resettable) GPBEmpty *reloadContacts;

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeersList *reloadHistory;

@end

/**
 * Clears whatever value was set for the oneof 'field'.
 **/
void ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField_ClearFieldOneOfCase(ObsoleteWeakUpdateBox_ObsoleteUpdateForceReloadState_ObsoleteForceReloadField *message);

#pragma mark - ObsoleteServiceUpdate

typedef GPB_ENUM(ObsoleteServiceUpdate_FieldNumber) {
  ObsoleteServiceUpdate_FieldNumber_ObsoleteUpdate = 1,
};

typedef GPB_ENUM(ObsoleteServiceUpdate_Update_OneOfCase) {
  ObsoleteServiceUpdate_Update_OneOfCase_GPBUnsetOneOfCase = 0,
  ObsoleteServiceUpdate_Update_OneOfCase_ObsoleteUpdate = 1,
};

GPB_FINAL @interface ObsoleteServiceUpdate : GPBMessage

@property(nonatomic, readonly) ObsoleteServiceUpdate_Update_OneOfCase updateOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) GPBBytesValue *obsoleteUpdate;

@end

/**
 * Clears whatever value was set for the oneof 'update'.
 **/
void ObsoleteServiceUpdate_ClearUpdateOneOfCase(ObsoleteServiceUpdate *message);

#pragma mark - ObsoleteWeakUpdateCommand

typedef GPB_ENUM(ObsoleteWeakUpdateCommand_FieldNumber) {
  ObsoleteWeakUpdateCommand_FieldNumber_SubscribeToOnlines = 1,
  ObsoleteWeakUpdateCommand_FieldNumber_UnsubscribeFromOnlines = 2,
  ObsoleteWeakUpdateCommand_FieldNumber_DropOnlineSubscriptions = 3,
  ObsoleteWeakUpdateCommand_FieldNumber_MyTyping = 7,
  ObsoleteWeakUpdateCommand_FieldNumber_SubscribeToTypings = 8,
  ObsoleteWeakUpdateCommand_FieldNumber_UnsubscribeFromTypings = 9,
  ObsoleteWeakUpdateCommand_FieldNumber_DropTypingSubscriptions = 10,
  ObsoleteWeakUpdateCommand_FieldNumber_SubscribeToEventBusUpdates = 11,
  ObsoleteWeakUpdateCommand_FieldNumber_MyOnline = 12,
};

typedef GPB_ENUM(ObsoleteWeakUpdateCommand_Command_OneOfCase) {
  ObsoleteWeakUpdateCommand_Command_OneOfCase_GPBUnsetOneOfCase = 0,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_SubscribeToOnlines = 1,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_UnsubscribeFromOnlines = 2,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_DropOnlineSubscriptions = 3,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_MyTyping = 7,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_SubscribeToTypings = 8,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_UnsubscribeFromTypings = 9,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_DropTypingSubscriptions = 10,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_SubscribeToEventBusUpdates = 11,
  ObsoleteWeakUpdateCommand_Command_OneOfCase_MyOnline = 12,
};

GPB_FINAL @interface ObsoleteWeakUpdateCommand : GPBMessage

@property(nonatomic, readonly) ObsoleteWeakUpdateCommand_Command_OneOfCase commandOneOfCase;

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeersList *subscribeToOnlines;

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeersList *unsubscribeFromOnlines;

@property(nonatomic, readwrite, strong, null_resettable) GPBEmpty *dropOnlineSubscriptions;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateCommand_ObsoleteMyTyping *myTyping;

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeersList *subscribeToTypings;

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeersList *unsubscribeFromTypings;

@property(nonatomic, readwrite, strong, null_resettable) GPBEmpty *dropTypingSubscriptions;

@property(nonatomic, readwrite, strong, null_resettable) GPBEmpty *subscribeToEventBusUpdates;

@property(nonatomic, readwrite, strong, null_resettable) ObsoleteWeakUpdateCommand_ObsoleteMyOnline *myOnline;

@end

/**
 * Clears whatever value was set for the oneof 'command'.
 **/
void ObsoleteWeakUpdateCommand_ClearCommandOneOfCase(ObsoleteWeakUpdateCommand *message);

#pragma mark - ObsoleteWeakUpdateCommand_ObsoleteMyTyping

typedef GPB_ENUM(ObsoleteWeakUpdateCommand_ObsoleteMyTyping_FieldNumber) {
  ObsoleteWeakUpdateCommand_ObsoleteMyTyping_FieldNumber_Peer = 1,
  ObsoleteWeakUpdateCommand_ObsoleteMyTyping_FieldNumber_Type = 2,
  ObsoleteWeakUpdateCommand_ObsoleteMyTyping_FieldNumber_Start = 3,
};

GPB_FINAL @interface ObsoleteWeakUpdateCommand_ObsoleteMyTyping : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) ObsoletePeer *peer;
/** Test to see if @c peer has been set. */
@property(nonatomic, readwrite) BOOL hasPeer;

@property(nonatomic, readwrite) ObsoleteTypingType type;

@property(nonatomic, readwrite) BOOL start;

@end

/**
 * Fetches the raw value of a @c ObsoleteWeakUpdateCommand_ObsoleteMyTyping's @c type property, even
 * if the value was not defined by the enum at the time the code was generated.
 **/
int32_t ObsoleteWeakUpdateCommand_ObsoleteMyTyping_Type_RawValue(ObsoleteWeakUpdateCommand_ObsoleteMyTyping *message);
/**
 * Sets the raw value of an @c ObsoleteWeakUpdateCommand_ObsoleteMyTyping's @c type property, allowing
 * it to be set to a value that was not defined by the enum at the time the code
 * was generated.
 **/
void SetObsoleteWeakUpdateCommand_ObsoleteMyTyping_Type_RawValue(ObsoleteWeakUpdateCommand_ObsoleteMyTyping *message, int32_t value);

#pragma mark - ObsoleteWeakUpdateCommand_ObsoleteMyOnline

typedef GPB_ENUM(ObsoleteWeakUpdateCommand_ObsoleteMyOnline_FieldNumber) {
  ObsoleteWeakUpdateCommand_ObsoleteMyOnline_FieldNumber_Online = 1,
};

GPB_FINAL @interface ObsoleteWeakUpdateCommand_ObsoleteMyOnline : GPBMessage

@property(nonatomic, readwrite) BOOL online;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)

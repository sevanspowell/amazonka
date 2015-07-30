{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.RDS.CopyOptionGroup
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Copies the specified option group.
--
-- <http://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CopyOptionGroup.html>
module Network.AWS.RDS.CopyOptionGroup
    (
    -- * Request
      CopyOptionGroup
    -- ** Request constructor
    , copyOptionGroup
    -- ** Request lenses
    , cTags
    , cSourceOptionGroupIdentifier
    , cTargetOptionGroupIdentifier
    , cTargetOptionGroupDescription

    -- * Response
    , CopyOptionGroupResponse
    -- ** Response constructor
    , copyOptionGroupResponse
    -- ** Response lenses
    , cogrsOptionGroup
    , cogrsStatus
    ) where

import           Network.AWS.Prelude
import           Network.AWS.RDS.Types
import           Network.AWS.Request
import           Network.AWS.Response

-- |
--
-- /See:/ 'copyOptionGroup' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cTags'
--
-- * 'cSourceOptionGroupIdentifier'
--
-- * 'cTargetOptionGroupIdentifier'
--
-- * 'cTargetOptionGroupDescription'
data CopyOptionGroup = CopyOptionGroup'
    { _cTags                         :: !(Maybe [Tag])
    , _cSourceOptionGroupIdentifier  :: !Text
    , _cTargetOptionGroupIdentifier  :: !Text
    , _cTargetOptionGroupDescription :: !Text
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'CopyOptionGroup' smart constructor.
copyOptionGroup :: Text -> Text -> Text -> CopyOptionGroup
copyOptionGroup pSourceOptionGroupIdentifier_ pTargetOptionGroupIdentifier_ pTargetOptionGroupDescription_ =
    CopyOptionGroup'
    { _cTags = Nothing
    , _cSourceOptionGroupIdentifier = pSourceOptionGroupIdentifier_
    , _cTargetOptionGroupIdentifier = pTargetOptionGroupIdentifier_
    , _cTargetOptionGroupDescription = pTargetOptionGroupDescription_
    }

-- | FIXME: Undocumented member.
cTags :: Lens' CopyOptionGroup [Tag]
cTags = lens _cTags (\ s a -> s{_cTags = a}) . _Default . _Coerce;

-- | The identifier or ARN for the source option group.
--
-- Constraints:
--
-- -   Must specify a valid option group.
-- -   If the source option group is in the same region as the copy,
--     specify a valid option group identifier, for example
--     @my-option-group@, or a valid ARN.
-- -   If the source option group is in a different region than the copy,
--     specify a valid option group ARN, for example
--     @arn:aws:rds:us-west-2:123456789012:og:special-options@.
cSourceOptionGroupIdentifier :: Lens' CopyOptionGroup Text
cSourceOptionGroupIdentifier = lens _cSourceOptionGroupIdentifier (\ s a -> s{_cSourceOptionGroupIdentifier = a});

-- | The identifier for the copied option group.
--
-- Constraints:
--
-- -   Cannot be null, empty, or blank
-- -   Must contain from 1 to 255 alphanumeric characters or hyphens
-- -   First character must be a letter
-- -   Cannot end with a hyphen or contain two consecutive hyphens
--
-- Example: @my-option-group@
cTargetOptionGroupIdentifier :: Lens' CopyOptionGroup Text
cTargetOptionGroupIdentifier = lens _cTargetOptionGroupIdentifier (\ s a -> s{_cTargetOptionGroupIdentifier = a});

-- | The description for the copied option group.
cTargetOptionGroupDescription :: Lens' CopyOptionGroup Text
cTargetOptionGroupDescription = lens _cTargetOptionGroupDescription (\ s a -> s{_cTargetOptionGroupDescription = a});

instance AWSRequest CopyOptionGroup where
        type Sv CopyOptionGroup = RDS
        type Rs CopyOptionGroup = CopyOptionGroupResponse
        request = postQuery
        response
          = receiveXMLWrapper "CopyOptionGroupResult"
              (\ s h x ->
                 CopyOptionGroupResponse' <$>
                   (x .@? "OptionGroup") <*> (pure (fromEnum s)))

instance ToHeaders CopyOptionGroup where
        toHeaders = const mempty

instance ToPath CopyOptionGroup where
        toPath = const mempty

instance ToQuery CopyOptionGroup where
        toQuery CopyOptionGroup'{..}
          = mconcat
              ["Action" =: ("CopyOptionGroup" :: ByteString),
               "Version" =: ("2014-10-31" :: ByteString),
               "Tags" =: toQuery (toQueryList "Tag" <$> _cTags),
               "SourceOptionGroupIdentifier" =:
                 _cSourceOptionGroupIdentifier,
               "TargetOptionGroupIdentifier" =:
                 _cTargetOptionGroupIdentifier,
               "TargetOptionGroupDescription" =:
                 _cTargetOptionGroupDescription]

-- | /See:/ 'copyOptionGroupResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cogrsOptionGroup'
--
-- * 'cogrsStatus'
data CopyOptionGroupResponse = CopyOptionGroupResponse'
    { _cogrsOptionGroup :: !(Maybe OptionGroup)
    , _cogrsStatus      :: !Int
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | 'CopyOptionGroupResponse' smart constructor.
copyOptionGroupResponse :: Int -> CopyOptionGroupResponse
copyOptionGroupResponse pStatus_ =
    CopyOptionGroupResponse'
    { _cogrsOptionGroup = Nothing
    , _cogrsStatus = pStatus_
    }

-- | FIXME: Undocumented member.
cogrsOptionGroup :: Lens' CopyOptionGroupResponse (Maybe OptionGroup)
cogrsOptionGroup = lens _cogrsOptionGroup (\ s a -> s{_cogrsOptionGroup = a});

-- | FIXME: Undocumented member.
cogrsStatus :: Lens' CopyOptionGroupResponse Int
cogrsStatus = lens _cogrsStatus (\ s a -> s{_cogrsStatus = a});

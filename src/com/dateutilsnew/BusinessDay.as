/**
 * Copyright (c) 2008 Gareth Arch
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/** 
 * This utility class packages together various functions for manipulation and calculation of dates
 * based upon business days.
 */
 
package com.dateutilsnew {

	public class BusinessDay {
		
		// creates default standard business week
		private static var _businessWeek:Object = null;
		public static function get businessWeek():Object {
			if ( !_businessWeek ) {
				_businessWeek = {};
				_businessWeek[ DateUtils.MONDAY ] = DateUtils.dayOfWeekAsNumber( DateUtils.MONDAY );
				_businessWeek[ DateUtils.TUESDAY ] = DateUtils.dayOfWeekAsNumber( DateUtils.TUESDAY );
				_businessWeek[ DateUtils.WEDNESDAY ] = DateUtils.dayOfWeekAsNumber( DateUtils.WEDNESDAY );
				_businessWeek[ DateUtils.THURSDAY ] = DateUtils.dayOfWeekAsNumber( DateUtils.THURSDAY );
				_businessWeek[ DateUtils.FRIDAY ] = DateUtils.dayOfWeekAsNumber( DateUtils.FRIDAY );
			}
			return _businessWeek;
		}

		public function BusinessDay() {
		}
		
		/**
		 * Returns an array of dates based upon a start and end date
		 * 
		 * @param startDate		Start of date range
		 * @param endDate		End of date range
		 * @param businessDays	A customized business week
		 * 
		 * @return				An array of dates representing all business days 
		 */
		public static function businessDaysInDateRange( startDate:Date, endDate:Date, businessDays:Object=null ):Array {
			var _arrReturn:Array = [];
			
			// make sure startDate is before endDate.  If not, switch dates
			if ( DateUtils.dateDiff( DateUtils.DAY_OF_MONTH, startDate, endDate ) < 0 ) {
				return BusinessDay.businessDaysInDateRange( endDate, startDate, businessDays );
			}

			var _currentDate:Date = startDate;

			while ( DateUtils.dateDiff( DateUtils.DAY_OF_MONTH, _currentDate, endDate ) >= 0 ) {
				for each ( var _businessDay:Number in businessDays ) {
					if ( DateUtils.dayOfWeek( _currentDate ) == _businessDay ) {
						_arrReturn.push( _currentDate );
						break;
					}
				}
				_currentDate = DateUtils.dateAdd( DateUtils.DAY_OF_MONTH, 1, _currentDate );
			}
			
			return _arrReturn;
		}
		
		/**
		 * Returns an array of dates based upon a start and end date
		 * 
		 * @param startDate		Start of date range
		 * @param endDate		End of date range
		 * @param businessDays	A customized business week
		 * 
		 * @return				An array of dates representing all non-business days 
		 */
		public static function nonBusinessDaysInDateRange( startDate:Date, endDate:Date, validBusinessDays:Object=null ):Array {
			return BusinessDay.createBusinessDays( startDate, endDate, validBusinessDays, false );
		}
		
		/**
		 * @private
		 * 
		 * Creates business/non-business days to pass to businessDaysInDateRange
		 * 
		 * @param startDate				Start of date range
		 * @param endDate				End of date range
		 * @param businessDays			A customized business week
		 * @param returnBusinessDays	Whether to return non-business or business days
		 * 
		 * @return						An array of dates representing all business/non-business days
		 */
		private static function createBusinessDays( startDate:Date, endDate:Date, businessDays:Object=null, returnBusinessDays:Boolean=true ):Array {
			if ( !businessDays ) {
				businessDays = businessWeek;
			}
			if ( !returnBusinessDays ) {
				var _newBusinessDays:Object = {};
				for ( var _businessDay:String in DateUtils.objDaysOfWeek ) {
					if ( !( businessDays[ _businessDay ] >= 0 ) ) {
						_newBusinessDays[ _businessDay ] = DateUtils.dayOfWeekAsNumber( _businessDay );
					}
				}
				businessDays = _newBusinessDays;
			}
			
			return businessDaysInDateRange( startDate, endDate, businessDays );
		}
		
		/**
		 * Returns a object containing valid business days from an array of string daysOfWeek
		 * 
		 * @param arrBusinessDays	An array of string daysOfWeek
		 * 
		 * @return					An object with valid business days
		 */
		public static function createBusinessObjectFromString( arrBusinessDays:Array ):Object {
			var returnBusinessDays:Object = {};

			arrBusinessDays.forEach( function( item:*, index:uint, array:Array ):void {
				if ( DateUtils.objDaysOfWeek[ item ] >= 0 ) {
					returnBusinessDays[ item ] = DateUtils.objDaysOfWeek[ item ];
				}
			} );
			
			return returnBusinessDays;
		}
		
		/**
		 * Returns an array of dates based for a specified month
		 * 
		 * @param date			Contains the month and year to search
		 * @param businessDays	A customized business week
		 * 
		 * @return				An array of dates representing all business days for the month
		 */
		public static function businessDaysForMonth( date:Date, businessDays:Object=null ):Array {
			return BusinessDay.businessDaysInDateRange( new Date( date.fullYear, date.month, 1 ),
														new Date( date.fullYear, date.month, DateUtils.daysInMonth( date ) ),
														businessDays );
		}
		
		
		/**
		 * Returns an array of non-business days for a specified month
		 * 
		 * @param date			Contains the month and year to search
		 * @param businessDays	A customized business week
		 * 
		 * @return				An array of dates representing all non-business days for the month
		 */
		public static function nonBusinessDaysForMonth( date:Date, validBusinessDays:Object=null ):Array {
			return BusinessDay.createBusinessDays( new Date( date.fullYear, date.month, 1 ),
														new Date( date.fullYear, date.month, DateUtils.daysInMonth( date ) ),
														validBusinessDays, false );
		}
		
		/**
		 * Returns an array of dates from the start date to the specified amount of time
		 * 
		 * @param startDate		Start date of iteration
		 * @param iteration		Total amount of time for which to return business days
		 * @param datePart		Type of time that iteration represents, i.e. days, weeks
		 * 
		 * @return				An array of dates representing all business days for the iteration
		 */
		public static function iterationOfBusinessDays( startDate:Date, iteration:Number, datePart:String, businessDays:Object=null ):Array {
			// need to subtract one as start date is "Day One"
			return BusinessDay.businessDaysInDateRange( startDate, DateUtils.dateAdd( datePart, iteration - 1, startDate ), businessDays );
		}
		
		/**
		 * Returns an array of dates from the start date to the specified amount of time
		 * 
		 * @param startDate		Start date of iteration
		 * @param iteration		Total amount of time for which to return business days
		 * @param datePart		Type of time that iteration represents, i.e. days, weeks
		 * 
		 * @return				An array of dates representing all non-business days for the iteration
		 */
		public static function iterationOfNonBusinessDays( startDate:Date, iteration:Number, datePart:String, validBusinessDays:Object=null ):Array {
			// need to subtract one as start date is "Day One"
			return BusinessDay.createBusinessDays( startDate, DateUtils.dateAdd( datePart, iteration - 1, startDate ), validBusinessDays, false );
		}

		/**
		 * Gets the quarter of the year based upon the fiscal year start date
		 * 
		 * @param date					The date for which to get the quarter of the year
		 * @param fiscalYearStartDate	The date that begins the fiscal year 
		 * 
		 * @return		A number representing the quarter of the year, 1 to 4
		 */
		public static function fiscalQuarter( date:Date, fiscalYearStartDate:Date=null ):uint {
			var _fiscalYearStartOffset:Number = 0;
			
			if ( fiscalYearStartDate != null ) {
				_fiscalYearStartOffset = Math.ceil( fiscalYearStartDate.month / 3 ) - 1;
			}

			return Math.ceil( DateUtils.dateAdd( DateUtils.MONTH, _fiscalYearStartOffset * -3, date ).month / 3 );
		}
	}
}